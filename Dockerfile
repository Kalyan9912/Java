FROM gcr.io/distroless/java21
WORKDIR /app
COPY target/*.jar app.jar
CMD ["app.jar"]
