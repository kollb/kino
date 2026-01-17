# Multi-stage build for Kino application

# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy all source files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests -Dgit-code-format-maven-plugin.phase=none

# Stage 2: Create runtime image
FROM quay.io/wildfly/wildfly:27.0.1.Final-jdk17

# Download MySQL JDBC driver
ADD --chown=jboss:jboss https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar /tmp/mysql-connector-j.jar

# Copy WildFly configuration script and entrypoint
COPY --chown=jboss:jboss configure-wildfly.cli /tmp/configure-wildfly.cli
COPY --chown=jboss:jboss docker-entrypoint.sh /opt/jboss/docker-entrypoint.sh

# Configure WildFly datasource and prepare entrypoint script
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/tmp/configure-wildfly.cli && \
    rm /tmp/configure-wildfly.cli && \
    # Use /tmp for sed temp files to avoid permission issues on Windows
    TMPDIR=/tmp sed -i 's/\r$//' /opt/jboss/docker-entrypoint.sh && \
    chmod +x /opt/jboss/docker-entrypoint.sh

# Copy WAR file from builder stage
COPY --from=builder /app/target/kino.war /opt/jboss/wildfly/standalone/deployments/

# Expose WildFly ports
EXPOSE 8080 9990

# Use custom entrypoint to configure datasource at runtime
ENTRYPOINT ["/opt/jboss/docker-entrypoint.sh"]
