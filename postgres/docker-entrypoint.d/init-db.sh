#!/bin/bash
set -e

: ${DB_NAME:=$1}
: ${DB_USER:='postgres'}
: ${DB_DUMP_PATH:='/db/dumps/latest.dump'}

if [ -e $DB_DUMP_PATH ]
then
  dropdb -U $DB_USER -e --if-exists $1 && \
  createdb -U $DB_USER $1 && \
  pg_restore -U $DB_USER --dbname=$1 \
   --clean --no-owner --no-privileges --verbose --jobs=3 \
  $DB_DUMP_PATH && \
  echo "Merged in latest database dump.";
fi
