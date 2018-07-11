#!/bin/bash
set -e

: ${DB_NAME:=$1}
: ${DB_DUMP_PATH:=/db/dumps/latest.dump}

dropdb -U postgres -e --if-exists $1 && \
createdb -U postgres $1 && \
pg_restore -U postgres --dbname=$1 \
 --clean --no-owner --no-privileges --verbose --jobs=3 \
 $DB_DUMP_PATH
