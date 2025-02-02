using Amazon.Lambda.AspNetCoreServer;

namespace WebApplication1
{
    public class Function : APIGatewayHttpApiV2ProxyFunction
    {
        protected override void Init(IWebHostBuilder builder)
        {
            builder.UseStartup<Startup>();
        }
    }
}