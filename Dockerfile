# syntax=docker/dockerfile:1.4

# Build stage
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Deploy stage
FROM eclipse-temurin:17-jre-jammy
VOLUME /tmp
COPY --from=build /app/target/producer-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]