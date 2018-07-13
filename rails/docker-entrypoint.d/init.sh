#! /bin/sh

# The Docker App Container's development entrypoint.
# This is a script used by the project's Docker development environment to
# setup the app containers and databases upon runnning.

: ${ENTRYPOINT_TASKS="/usr/local/scripts"}
: ${APP_PATH:="/usr/src/app"}

$ENTRYPOINT_TASKS/wait-for-services.sh
$ENTRYPOINT_TASKS/migrate.sh
$ENTRYPOINT_TASKS/webpacker.sh
bundle exec puma -C config/puma.rb
