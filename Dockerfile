# Use the AWS Lambda .NET 8 base image
FROM public.ecr.aws/lambda/dotnet:8 AS base

# Set the working directory
WORKDIR /var/task

# Copy the project file(s)
COPY ["WebApplication1/WebApplication1.csproj", "WebApplication1/"]

# Restore dependencies
RUN dotnet restore "./WebApplication1/WebApplication1.csproj"

# Copy the rest of the application code
COPY . .

# Build the application
WORKDIR "/src/WebApplication1"
RUN dotnet build "WebApplication1.csproj" -c Release -o /app/build

# Publish the application
FROM public.ecr.aws/lambda/dotnet:8 AS publish
WORKDIR "/src/WebApplication1"
COPY --from=base /src/WebApplication1 .
RUN dotnet publish "WebApplication1.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Copy the published application to the Lambda runtime directory
FROM base AS final
WORKDIR /var/task
COPY --from=publish /app/publish .

# Set the handler for the Lambda function
# Replace 'YourNamespace::LambdaEntryPoint::FunctionHandlerAsync' with your actual handler
CMD ["WebApplication1::LambdaEntryPoint::FunctionHandlerAsync"]