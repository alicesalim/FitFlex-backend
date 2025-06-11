# Etapa 1: Build do projeto com JDK 17
FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Imagem leve de execução com JDK 17
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/target/app.jar app.jar
EXPOSE 8080  

ENTRYPOINT ["java", "-jar", "app.jar"]


