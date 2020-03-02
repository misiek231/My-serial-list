using Microsoft.AspNetCore.Http;
using Swashbuckle.AspNetCore.Swagger;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Collections.Generic;
using System.Linq;

namespace MySerialList.WebApi.Filters
{
    public class FormFileOperationFilter : IOperationFilter
    {
        public void Apply(Operation operation, OperationFilterContext context)
        {
            if (operation.Parameters == null)
            {
                return;
            }

            List<string> fileParamNames = context.ApiDescription.ActionDescriptor.Parameters
                .SelectMany(x => x.ParameterType.GetProperties())
                .Where(x => x.PropertyType.IsAssignableFrom(typeof(IFormFile)))
                .Select(x => x.Name)
                .ToList();
            if (!fileParamNames.Any())
            {
                return;
            }

            List<IParameter> paramsToRemove = new List<IParameter>();
            foreach (IParameter param in operation.Parameters)
            {
                paramsToRemove.AddRange(from fileParamName in fileParamNames where param.Name.StartsWith(fileParamName + ".") select param);
            }
            paramsToRemove.ForEach(x => operation.Parameters.Remove(x));
            foreach (string paramName in fileParamNames)
            {
                NonBodyParameter fileParam = new NonBodyParameter
                {
                    Type = "file",
                    Name = paramName,
                    In = "formData"
                };
                operation.Parameters.Add(fileParam);
            }
            foreach (IParameter param in operation.Parameters)
            {
                param.In = "formData";
            }

            operation.Consumes = new List<string>() { "multipart/form-data" };
        }
    }

}
