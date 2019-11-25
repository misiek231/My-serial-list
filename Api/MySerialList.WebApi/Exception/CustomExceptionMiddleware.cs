using Microsoft.AspNetCore.Http;
using MySerialList.Service.Exception;
using System.Threading.Tasks;

namespace MySerialList.WebApi.Exception
{
    public class CustomExceptionMiddleware
    {
        private readonly RequestDelegate next;

        public CustomExceptionMiddleware(RequestDelegate next)
        {
            this.next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await next(context);
            }
            catch (HttpStatusCodeException exception)
            {
                context.Response.ContentType = "text/plain; charset=utf-8";
                context.Response.StatusCode = (int)exception.StatusCode;
                await context.Response.WriteAsync(exception.Message);
            }
        }
    }
}
