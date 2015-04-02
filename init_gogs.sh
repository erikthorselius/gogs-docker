#!/bin/sh

if [ ! -d "$GOGS_CUSTOM_CONF_PATH" ]; then
    mkdir -p $GOGS_CUSTOM_CONF_PATH

echo "
[database]
DB_TYPE = postgres
HOST = ${DB_1_PORT_5432_TCP_ADDR}:${DB_1_PORT_5432_TCP_PORT}
NAME = ${DB_1_ENV_POSTGRESQL_DB}
USER = ${DB_1_ENV_POSTGRESQL_USER}
PASSWD = ${DB_1_ENV_POSTGRESQL_PASS}

" >> $GOGS_CUSTOM_CONF
    
fi

exec "$@"
