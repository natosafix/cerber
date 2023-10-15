FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Cerber/Cerber.csproj", "Cerber/"]
RUN dotnet restore "Cerber/Cerber.csproj"
COPY . .
WORKDIR "/src/Cerber"
RUN dotnet build "Cerber.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Cerber.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Cerber.dll"]
