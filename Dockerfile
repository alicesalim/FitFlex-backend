# Etapa 1: Build do projeto
FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Imagem leve de execução
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

COPY --from=build /app/target/app.jar app.jar
EXPOSE 8080  # ou 4567, dependendo da porta do Spark

ENTRYPOINT ["java", "-jar", "app.jar"]
