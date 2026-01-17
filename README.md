|Build|Code Coverage|Code Quality|
|--|--|--|
|[![Build and Test](https://github.com/kollb/kino/actions/workflows/build.yml/badge.svg)](https://github.com/kollb/kino/actions/workflows/build.yml)|[![codecov](https://codecov.io/gh/kollb/kino/branch/master/graph/badge.svg)](https://codecov.io/gh/kollb/kino)|[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=kollb_kino&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=kollb_kino)|

# Kino

A RESTful Cinema API built with Jakarta EE. The frontend is built with Angular and contained in the final build.

## Quick Start with Docker

The easiest way to run the application is using Docker Compose:

```bash
# Build and start the application (includes MySQL with sample data)
docker-compose up --build

# Access the application at http://localhost:8080/kino
# Admin panel: http://localhost:9990 (WildFly admin console)
```

The Docker setup includes:
- WildFly 27 application server with the Kino application deployed
- MySQL 8.2 database with pre-loaded sample data (movies, users, cinema halls)
- Automatic database initialization with schema and demo data

**Default Login Credentials:**
- Admin: `admin@account.de` / `admin`
- Moderator: `moderator@account.de` / `moderator`
- Customer: `customer@account.de` / `customer`

## Running the server

### Requirements
-	Maven 3.9+	(https://maven.apache.org/download.cgi)
-	Java 17 (LTS)	(https://adoptium.net/)
-	Node 14.x	(https://nodejs.org/en/) - for Angular 7 frontend

### Build

```bash
# Build the WAR file
mvn clean package

# Skip tests for faster build
mvn clean package -DskipTests
```

### Deployment Options

#### Option 1: Docker (Recommended)

```bash
# Using Docker Compose (includes MySQL)
docker-compose up --build

# Or build and run manually
docker build -t kino .
docker run -p 8080:8080 -p 9990:9990 kino
```

#### Option 2: Traditional WildFly Deployment

Requirements:
-	Java 17		(https://adoptium.net/)
-	WildFly 27+	(https://wildfly.org/downloads/)
-	MySQL 8.x	(https://www.mysql.com/downloads/)
-	Executable kino.war	(from build)

Steps:
1. Set up MySQL database (see Database Setup below)
2. Copy `target/kino.war` to `$WILDFLY_HOME/standalone/deployments/`
3. Start WildFly: `$WILDFLY_HOME/bin/standalone.sh` (or `.bat` on Windows)
4. Access at http://localhost:8080/kino

### Database Setup
-	Use SQL scripts in `sql-scripts` folder
-	For Docker: Database is automatically initialized with `sql-scripts/init-docker.sql`
-	Docker database credentials:
    - User: `kino`
    - Password: `kino`
-	Local development credentials (for manual MySQL setup):
    - User: `jpa`
    - Password: `jpa`

Or with standalone Docker MySQL:
```bash
docker run -d \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=kino \
  -e MYSQL_USER=kino \
  -e MYSQL_PASSWORD=kino \
  -p 3306:3306 \
  -v $(pwd)/sql-scripts/init-docker.sql:/docker-entrypoint-initdb.d/init.sql \
  mysql:8.2
```

## Development

### Run Tests
```bash
mvn test
```

### Code Formatting
The project uses Google Java Format with git hooks:
```bash
mvn git-code-format:validate-code-format
```

## Security Notes

**⚠️ CRITICAL - Angular Security Issues:**

Angular 7.2.x has **multiple unpatched XSS vulnerabilities** with no fixes available for this version:
- XSRF Token Leakage via Protocol-Relative URLs
- XSS via Unsanitized SVG Script Attributes  
- Stored XSS via SVG Animation, SVG URL and MathML Attributes

**These vulnerabilities only have patches in Angular 19+, 20+, and 21+.**

**RECOMMENDATION:** Upgrade to Angular 19+ (LTS) for security patches. This requires significant code changes and was beyond the scope of this modernization effort.

**⚠️ Important:** This is a development/demonstration project. For production use, you must:

1. **URGENT: Upgrade Angular to 19+ or later** to fix XSS vulnerabilities
2. **Change the JWT secret key** in `JwtTokenFactory.java` - externalize it to environment variables
3. **Update database credentials** - use secure credentials and externalize them
4. **Use HTTPS** - configure SSL/TLS certificates
5. **Review and update** all hardcoded credentials and secrets

The docker-compose.yml file is intended for **local development only** and should not be used in production.
  
## Dummy Login

Test accounts for development:

-	**Admin Account:**
    - User: `admin@account.de`
    - Password: `admin`
-	**Moderator Account:**
    -	User: `moderator@account.de`
    -	Password: `moderator`
-	**Customer Account:**
    -	User: `customer@account.de`
    -	Password: `customer`
-	**Customer1 Account:**
    -	User: `customer1@account.de`
    -	Password: `customer1`

## Technology Stack

- **Backend:** Jakarta EE 10 (Java 17), Jersey 3.1.5 (JAX-RS), Hibernate 6.4.4 (JPA)
- **Frontend:** Angular 7, TypeScript, Material Design
- **Database:** MySQL 8.2
- **Server:** WildFly 27 (Jakarta EE 10)
- **Build:** Maven 3.9+
- **API Documentation:** OpenAPI 3 (Swagger)

**Note:** This application has been migrated from Java EE 8 (javax.*) to Jakarta EE 10 (jakarta.*) for compatibility with WildFly 27.
