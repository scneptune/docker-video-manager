#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER atv_user;
    CREATE DATABASE video;
    CREATE DATABASE video_development;
    CREATE DATABASE video_test;
    GRANT ALL PRIVILEGES ON DATABASE video TO atv_user;
    GRANT ALL PRIVILEGES ON DATABASE video_development TO atv_user;
    GRANT ALL PRIVILEGES ON DATABASE video_test TO atv_user;
EOSQL
