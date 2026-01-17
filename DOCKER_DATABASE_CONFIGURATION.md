# Docker Database Configuration

## Problem Statement

**Question (German):** "Muss dockerfile dann angepasst werden wegen db oder db daten etc?"  
**Translation:** "Does the dockerfile then need to be adjusted because of db or db data etc?"

**Answer:** Yes, the Dockerfile and related configuration files needed significant adjustments to properly configure the database connection.

## What Was Wrong

Before these changes:
- **Hardcoded database connection** in `persistence.xml` (mysql:3306 with user kino/kino)
- **No environment variable support** for database configuration
- **Wrong transaction type** (RESOURCE_LOCAL instead of JTA for container-managed transactions)
- **Volume mount override** in docker-compose.yml prevented proper image usage
- Application would fail to connect to database with different credentials or host

## What Was Changed

### 1. Dockerfile
- Added multi-stage build (builder + runtime)
- Downloads and installs MySQL JDBC driver (8.2.0)
- Configures WildFly datasource during image build
- Uses custom entrypoint script for runtime configuration

### 2. configure-wildfly.cli (New File)
```bash
# Creates MySQL module in WildFly
# Registers MySQL JDBC driver
# Creates datasource with default connection settings
```

### 3. docker-entrypoint.sh (New File)
```bash
# Starts WildFly in background
# Waits for server to be ready (with 60s timeout)
# Updates datasource from environment variables:
#   - DB_HOST (default: mysql)
#   - DB_PORT (default: 3306)
#   - DB_NAME (default: kino)
#   - DB_USER (default: kino)
#   - DB_PASSWORD (default: kino)
# Reloads configuration
# Runs WildFly in foreground
```

### 4. persistence.xml
**Before:**
```xml
<persistence-unit name="kino" transaction-type="RESOURCE_LOCAL">
    <property name="jakarta.persistence.jdbc.driver" value="com.mysql.cj.jdbc.Driver"/>
    <property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://mysql:3306/kino?..."/>
    <property name="jakarta.persistence.jdbc.user" value="kino"/>
    <property name="jakarta.persistence.jdbc.password" value="kino"/>
</persistence-unit>
```

**After:**
```xml
<persistence-unit name="kino" transaction-type="JTA">
    <jta-data-source>java:jboss/datasources/KinoDS</jta-data-source>
    <!-- No hardcoded connection details -->
</persistence-unit>
```

### 5. docker-compose.yml
- Removed: `- ./target/kino.war:/opt/jboss/wildfly/standalone/deployments/kino.war`
- WAR file now built into Docker image

## How It Works Now

1. **Build Time:**
   - Maven builds the WAR file
   - Docker image includes WAR file
   - MySQL JDBC driver installed in WildFly
   - Datasource created with default values

2. **Runtime:**
   - Container starts
   - Entrypoint script reads environment variables
   - Datasource configuration updated dynamically
   - WildFly starts with correct database connection
   - Application connects via JNDI lookup

## Usage

### With default settings (for local development):
```bash
docker compose up --build
```

### With custom database settings:
```yaml
services:
  wildfly:
    environment:
      - DB_HOST=my-mysql-server
      - DB_PORT=3307
      - DB_NAME=my_database
      - DB_USER=my_user
      - DB_PASSWORD=my_password
```

Or via command line:
```bash
docker run -e DB_HOST=myhost -e DB_PORT=3307 -e DB_NAME=mydb \
  -e DB_USER=myuser -e DB_PASSWORD=mypass kino-wildfly
```

## Benefits

✅ **Configurable**: Change database connection without rebuilding image  
✅ **Secure**: No hardcoded credentials in source code  
✅ **Proper Architecture**: Uses JTA container-managed transactions  
✅ **Production Ready**: Environment-based configuration  
✅ **Reliable**: Error handling and timeout protection  

## Files Modified

- `Dockerfile` - Multi-stage build with datasource configuration
- `configure-wildfly.cli` - WildFly datasource setup script
- `docker-entrypoint.sh` - Runtime configuration script
- `src/main/resources/META-INF/persistence.xml` - JTA + JNDI datasource
- `docker-compose.yml` - Removed volume mount

## Testing

After running `docker compose up --build`, verify:
- Application accessible at http://localhost:8080/kino
- No H2 database errors in logs
- MySQL connection successful
- Sample data loaded (movies, users, cinema halls)
- Default login credentials work (admin@account.de / admin)
