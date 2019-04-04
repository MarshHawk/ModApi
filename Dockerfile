FROM microsoft/dotnet:2.2-sdk as build
WORKDIR /app
COPY . /app
RUN dotnet publish -c Release -r linux-musl-x64 -o out

FROM microsoft/dotnet:2.2-runtime-deps-alpine
WORKDIR /app
COPY --from=build /app/out ./
ENV ASPNETCORE_ENVIRONMENT=Development
EXPOSE 9500/tcp
ENTRYPOINT [ "./GobiModApi" ]
