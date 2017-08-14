FROM microsoft/aspnetcore-build:1 AS develop
ENV ASPNETCORE_ENVIRONMENT=Development
EXPOSE 80
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore
COPY . .

FROM develop AS publish
RUN dotnet publish -c Release -o /app

FROM microsoft/aspnetcore:1 AS release
EXPOSE 80
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "my-dotnet-app.dll"]
