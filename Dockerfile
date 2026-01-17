# Multi-stage build for Kino application

# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml and download dependencies (better layer caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests -Dmaven.git.code.format.skip=true

# Stage 2: Create runtime image
FROM quay.io/wildfly/wildfly:27.0.1.Final-jdk17

# Copy WAR file from builder stage
COPY --from=builder /app/target/kino.war /opt/jboss/wildfly/standalone/deployments/

# Expose WildFly ports
EXPOSE 8080 9990

# Run WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
