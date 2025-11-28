# ===== Stage 1: Build with Maven =====
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and install the dependencies first 

COPY pom.xml .

# Copy project code

COPY . .

# Package the Spring Boot app
RUN mvn clean package -DskipTests

# # ===== Stage 2: Run application =====
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

## copy the build jar from the previous stage

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Run the app

ENTRYPOINT ["java","-jar","/app/app.jar"]
