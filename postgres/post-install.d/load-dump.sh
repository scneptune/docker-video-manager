#!/bin/bash
set -e

: ${DB_NAME:='video_manager-development'}
: ${DB_USER:='postgres'}
: ${DB_DUMP_PATH:='/db/dumps/latest.dump'}

if [ -e $DB_DUMP_PATH ]
then
  dropdb -U $DB_USER -e --if-exists $DB_NAME && \
  createdb -U $DB_USER $DB_NAME && \
  pg_restore -U $DB_USER --dbname=$DB_NAME \
   --clean --no-owner --no-privileges --verbose --jobs=3 \
  $DB_DUMP_PATH  && \
  echo "Merged in latest database dump.";
fi
