# Etapa 1: Build do projeto usando Maven + JDK 17
FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app

# Copia os arquivos necessários para o build
COPY pom.xml .
COPY src ./src

# Roda o build do Maven, ignorando testes
RUN mvn clean package -DskipTests

# Etapa 2: Imagem leve para rodar a aplicação
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copia o jar gerado da etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta 8080 (padrão do Spring Boot / backend Java)
EXPOSE 8080

# Comando para rodar o jar
ENTRYPOINT ["java", "-jar", "app.jar"]
