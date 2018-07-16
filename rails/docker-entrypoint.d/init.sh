#! /bin/sh

# The Docker App Container's development entrypoint.
# This is a script used by the project's Docker development environment to
# setup the app containers and databases upon runnning.
set -e

: ${ENTRYPOINT_TASKS="/usr/local/scripts"}
: ${NO_DUMP_RESTORE=$NO_DUMP_RESTORE}

$ENTRYPOINT_TASKS/wait-for-services.sh
if [ "$NO_DUMP_RESTORE" = false ]; then
  $ENTRYPOINT_TASKS/migrate.sh;
fi
$ENTRYPOINT_TASKS/webpacker.sh;

exec "$@"
