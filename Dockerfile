# Etapa de build: Utilizar uma imagem base com Maven e JDK 21 para construir o projeto
FROM eclipse-temurin:21-jdk AS build

# Define o diretório de trabalho dentro do container
WORKDIR /workspace

# Copiar o arquivo pom.xml e as dependências do Maven para o cache
COPY pom.xml ./
COPY src ./src/

# Executar o build do projeto Quarkus
RUN ./mvnw package -Dquarkus.package.type=fast-jar

# Etapa de execução: Utilizar uma imagem base com JDK 21 para rodar a aplicação
FROM registry.access.redhat.com/ubi9/openjdk-21:latest

# Definir o diretório de trabalho para a aplicação
WORKDIR /work/

# Copiar o resultado do build da primeira etapa
COPY --from=build /workspace/target/quarkus-app/lib/ ./lib/
COPY --from=build /workspace/target/quarkus-app/*.jar ./
COPY --from=build /workspace/target/quarkus-app/app/ ./app/
COPY --from=build /workspace/target/quarkus-app/quarkus/ ./quarkus/

# Expor a porta que a aplicação irá rodar
EXPOSE 8080

# Comando para iniciar a aplicação
CMD ["java", "-jar", "quarkus-run.jar"]
