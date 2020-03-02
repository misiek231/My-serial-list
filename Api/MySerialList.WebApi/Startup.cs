using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Service;
using MySerialList.WebApi.Exception;
using MySerialList.WebApi.Extensions;
using System;
using System.IO;

namespace MySerialList
{
    public class Startup
    {
        public Startup(IHostingEnvironment env)
        {
            IConfigurationBuilder builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
                .AddEnvironmentVariables();
            Configuration = builder.Build();
        }

        public IConfigurationRoot Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public IServiceProvider ConfigureServices(IServiceCollection services)
        {

            services.ConfigureAppCors();

            services.AddDbContext<MySerialListDBContext>(options =>
                options.UseSqlServer(Configuration.GetConnectionString("RemoteConnection")) // RemoteConnection, DebugConnection           
            );

            services.AddIdentity<User, IdentityRole>(options =>
            {
                options.Password.RequireDigit = false;
                options.Password.RequiredLength = 1;
                options.Password.RequiredUniqueChars = 0;
                options.Password.RequireLowercase = false;
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireUppercase = false;
                options.SignIn.RequireConfirmedEmail = true;
            }).AddDefaultTokenProviders()
              .AddEntityFrameworkStores<MySerialListDBContext>();

            services.ConfigureJwtAuthentication(Configuration);

            services.ConfigureSwagger();

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddSpaStaticFiles(configuration =>
            {
                configuration.RootPath = "wwwroot/build";
            });

            IServiceProvider serviceProvider = services.ConfigureAutofac();

            serviceProvider.CreateRoles(Configuration).Wait();

            return serviceProvider;
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            app.UseStaticFiles();

            AppSettings appSettings = Configuration.GetSection("AppSettings").Get<AppSettings>();
            string postersPath;

            if (env.IsDevelopment())
            {
                postersPath = appSettings.DebugPostersPath;
            }
            else
            {
                postersPath = appSettings.PostersPath;
            }

            app.UseFileServer(new FileServerOptions
            {
                FileProvider = new PhysicalFileProvider(postersPath),
                RequestPath = "/images",
                EnableDirectoryBrowsing = true
            });
            app.UseSpaStaticFiles();
            app.UseCors(b =>
            {
                b.AllowAnyHeader()
                .AllowAnyMethod()
                .AllowAnyOrigin()
                .AllowCredentials();
            });
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
            });

            app.UseAuthentication();    

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }

            app.UseMiddleware<CustomExceptionMiddleware>();

            app.UseMvcWithDefaultRoute();

            app.UseSpa(spa =>
            {
                spa.Options.SourcePath = "wwwroot/build";
            });

            app.UseHttpsRedirection();
        }
    }
}