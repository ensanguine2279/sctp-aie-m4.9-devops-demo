FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

ENV PORT=8080

COPY target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
