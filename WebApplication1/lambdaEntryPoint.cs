using Amazon.Lambda.AspNetCoreServer;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace WebApplication1
{
    /// <summary>
    /// LambdaEntryPoint inherits from APIGatewayProxyFunction which sets up the
    /// ASP.NET Core pipeline for handling API Gateway requests.
    /// </summary>
    public class LambdaEntryPoint : APIGatewayProxyFunction
    {
        /// <summary>
        /// Override the CreateHostBuilder so that it uses our Startup class.
        /// </summary>
        protected override IHostBuilder CreateHostBuilder()
        {
            return Host.CreateDefaultBuilder()
                       .ConfigureWebHostDefaults(webBuilder =>
                       {
                           webBuilder.UseStartup<Startup>();
                       });
        }
    }
}
