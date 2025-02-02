# Stage 1: Build and publish the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy and restore only the project file(s)
COPY ["WebApplication1.csproj", "./"]
RUN dotnet restore "WebApplication1.csproj"

# Copy the remaining files and build
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Build the Lambda container image using AWS’s base image for .NET 8
FROM public.ecr.aws/lambda/dotnet:8
WORKDIR /var/task
COPY --from=build /app/publish .

# The Lambda runtime will invoke the handler specified below.
# This must be in the format: Assembly::TypeName::MethodName
CMD ["WebApplication1::WebApplication1.LambdaEntryPoint::FunctionHandlerAsync"]
