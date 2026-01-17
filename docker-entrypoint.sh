#!/bin/bash
set -e

# Use environment variables or defaults for database connection
export DB_HOST=${DB_HOST:-mysql}
export DB_PORT=${DB_PORT:-3306}
export DB_NAME=${DB_NAME:-kino}
export DB_USER=${DB_USER:-kino}
export DB_PASSWORD=${DB_PASSWORD:-kino}

# Build the JDBC connection URL
JDBC_URL="jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}?useLegacyDatetimeCode=false&serverTimezone=UTC"

# Start WildFly in the background
/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
WILDFLY_PID=$!

# Wait for WildFly to start (max 60 seconds)
echo "Waiting for WildFly to start..."
COUNTER=0
MAX_WAIT=60
until /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command=":read-attribute(name=server-state)" 2>/dev/null | grep -q "running"; do
    sleep 2
    COUNTER=$((COUNTER + 2))
    if [ $COUNTER -ge $MAX_WAIT ]; then
        echo "ERROR: WildFly failed to start within ${MAX_WAIT} seconds"
        kill $WILDFLY_PID 2>/dev/null || true
        exit 1
    fi
done

echo "WildFly started, updating datasource configuration..."

# Update the datasource with environment variables
if ! /opt/jboss/wildfly/bin/jboss-cli.sh --connect <<EOF
/subsystem=datasources/data-source=KinoDS:write-attribute(name=connection-url,value="${JDBC_URL}")
/subsystem=datasources/data-source=KinoDS:write-attribute(name=user-name,value="${DB_USER}")
/subsystem=datasources/data-source=KinoDS:write-attribute(name=password,value="${DB_PASSWORD}")
:reload
EOF
then
    echo "ERROR: Failed to update datasource configuration"
    kill $WILDFLY_PID 2>/dev/null || true
    exit 1
fi

echo "Datasource configuration updated successfully."

# Wait for WildFly process
wait $WILDFLY_PID
