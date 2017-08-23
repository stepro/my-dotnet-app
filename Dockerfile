FROM microsoft/aspnetcore-build:1 AS develop
EXPOSE 80
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore
COPY . .

FROM develop AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish -c $BUILD_CONFIGURATION -o /app

FROM microsoft/aspnetcore:1 AS release
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "my-dotnet-app.dll"]
