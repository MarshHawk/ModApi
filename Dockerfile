FROM microsoft/aspnetcore:2.0-nanoserver-sac2016 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/aspnetcore-build:2.0-nanoserver-sac2016 AS build
WORKDIR /src
COPY GobiModApi/GobiModApi.csproj GobiModApi/
RUN dotnet restore GobiModApi/GobiModApi.csproj
COPY . .
WORKDIR /src/GobiModApi
RUN dotnet build GobiModApi.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish GobiModApi.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "GobiModApi.dll"]
