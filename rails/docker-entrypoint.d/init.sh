#!/bin/bash
set -e

# don't rerun this script but run all shell tasks in this folder.
for shellScript in `find ${INIT_TASKS} -not -name "init.sh"`
do
  exec shellScript
end
#  finally swap back to using bundle exec 
exec "bundle exec $@"
