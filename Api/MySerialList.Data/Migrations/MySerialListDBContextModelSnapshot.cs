﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using MySerialList.Data;

namespace MySerialList.Data.Migrations
{
    [DbContext(typeof(MySerialListDBContext))]
    partial class MySerialListDBContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.2.4-servicing-10062")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken();

                    b.Property<string>("Name")
                        .HasMaxLength(256);

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256);

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasName("RoleNameIndex")
                        .HasFilter("[NormalizedName] IS NOT NULL");

                    b.ToTable("AspNetRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType");

                    b.Property<string>("ClaimValue");

                    b.Property<string>("RoleId")
                        .IsRequired();

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType");

                    b.Property<string>("ClaimValue");

                    b.Property<string>("UserId")
                        .IsRequired();

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider");

                    b.Property<string>("ProviderKey");

                    b.Property<string>("ProviderDisplayName");

                    b.Property<string>("UserId")
                        .IsRequired();

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId");

                    b.Property<string>("RoleId");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId");

                    b.Property<string>("LoginProvider");

                    b.Property<string>("Name");

                    b.Property<string>("Value");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens");
                });

            modelBuilder.Entity("MySerialList.Data.Model.Comment", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("CreateAt");

                    b.Property<string>("Description");

                    b.Property<int>("FilmProductionId");

                    b.Property<string>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("FilmProductionId");

                    b.HasIndex("UserId");

                    b.ToTable("Comments");
                });

            modelBuilder.Entity("MySerialList.Data.Model.Episode", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("EpisodeNumber");

                    b.Property<int>("FilmProductionId");

                    b.Property<string>("Released");

                    b.Property<int>("Season");

                    b.Property<string>("Title");

                    b.HasKey("Id");

                    b.HasIndex("FilmProductionId");

                    b.ToTable("Episodes");
                });

            modelBuilder.Entity("MySerialList.Data.Model.FilmProduction", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Actors");

                    b.Property<string>("Director");

                    b.Property<string>("Genre");

                    b.Property<bool>("IsSeries");

                    b.Property<string>("Language");

                    b.Property<string>("Plot");

                    b.Property<string>("Poster");

                    b.Property<string>("Released");

                    b.Property<string>("Title");

                    b.HasKey("Id");

                    b.ToTable("FilmProductions");
                });

            modelBuilder.Entity("MySerialList.Data.Model.ReviewEpisode", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("EpisodeId");

                    b.Property<int>("Grade");

                    b.Property<string>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("EpisodeId");

                    b.HasIndex("UserId");

                    b.ToTable("EpisodeReviews");
                });

            modelBuilder.Entity("MySerialList.Data.Model.ReviewFilmProduction", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int?>("EpisodeId");

                    b.Property<int>("FilmProductionId");

                    b.Property<int>("Grade");

                    b.Property<string>("UserId");

                    b.HasKey("Id");

                    b.HasIndex("EpisodeId");

                    b.HasIndex("FilmProductionId");

                    b.HasIndex("UserId");

                    b.ToTable("FilmProductionReviews");
                });

            modelBuilder.Entity("MySerialList.Data.Model.User", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("AccessFailedCount");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken();

                    b.Property<string>("Email")
                        .HasMaxLength(256);

                    b.Property<bool>("EmailConfirmed");

                    b.Property<bool>("LockoutEnabled");

                    b.Property<DateTimeOffset?>("LockoutEnd");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256);

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256);

                    b.Property<string>("PasswordHash");

                    b.Property<string>("PhoneNumber");

                    b.Property<bool>("PhoneNumberConfirmed");

                    b.Property<string>("SecurityStamp");

                    b.Property<bool>("TwoFactorEnabled");

                    b.Property<string>("UserName")
                        .HasMaxLength(256);

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasName("UserNameIndex")
                        .HasFilter("[NormalizedUserName] IS NOT NULL");

                    b.ToTable("AspNetUsers");
                });

            modelBuilder.Entity("MySerialList.Data.Model.WatchingEpisodeStatus", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("EpisodeId");

                    b.Property<string>("UserId");

                    b.Property<int>("WatchingStatus");

                    b.HasKey("Id");

                    b.HasIndex("EpisodeId");

                    b.HasIndex("UserId");

                    b.ToTable("WatchingEpisodeStatuses");
                });

            modelBuilder.Entity("MySerialList.Data.Model.WatchingFilmProductionStatus", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Episodes");

                    b.Property<int>("FilmProductionId");

                    b.Property<string>("UserId");

                    b.Property<int>("WatchingStatus");

                    b.HasKey("Id");

                    b.HasIndex("FilmProductionId");

                    b.HasIndex("UserId");

                    b.ToTable("WatchingFilmProductionStatuses");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole")
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("MySerialList.Data.Model.User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("MySerialList.Data.Model.User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole")
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("MySerialList.Data.Model.User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("MySerialList.Data.Model.User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("MySerialList.Data.Model.Comment", b =>
                {
                    b.HasOne("MySerialList.Data.Model.FilmProduction", "FilmProduction")
                        .WithMany("Comments")
                        .HasForeignKey("FilmProductionId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("MySerialList.Data.Model.User", "User")
                        .WithMany("Comments")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("MySerialList.Data.Model.Episode", b =>
                {
                    b.HasOne("MySerialList.Data.Model.FilmProduction", "FilmProduction")
                        .WithMany("Episodes")
                        .HasForeignKey("FilmProductionId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("MySerialList.Data.Model.ReviewEpisode", b =>
                {
                    b.HasOne("MySerialList.Data.Model.Episode", "Episode")
                        .WithMany()
                        .HasForeignKey("EpisodeId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("MySerialList.Data.Model.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("MySerialList.Data.Model.ReviewFilmProduction", b =>
                {
                    b.HasOne("MySerialList.Data.Model.Episode")
                        .WithMany("Reviews")
                        .HasForeignKey("EpisodeId");

                    b.HasOne("MySerialList.Data.Model.FilmProduction", "FilmProduction")
                        .WithMany("Reviews")
                        .HasForeignKey("FilmProductionId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("MySerialList.Data.Model.User", "User")
                        .WithMany("Reviews")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("MySerialList.Data.Model.WatchingEpisodeStatus", b =>
                {
                    b.HasOne("MySerialList.Data.Model.Episode", "Episode")
                        .WithMany()
                        .HasForeignKey("EpisodeId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("MySerialList.Data.Model.User", "User")
                        .WithMany("WatchingEpisodeStatuses")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("MySerialList.Data.Model.WatchingFilmProductionStatus", b =>
                {
                    b.HasOne("MySerialList.Data.Model.FilmProduction", "FilmProduction")
                        .WithMany()
                        .HasForeignKey("FilmProductionId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("MySerialList.Data.Model.User", "User")
                        .WithMany("WatchingFilmProductionStatuses")
                        .HasForeignKey("UserId");
                });
#pragma warning restore 612, 618
        }
    }
}
