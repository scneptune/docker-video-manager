#!/bin/bash
set -e

# drop any previous server pids
rm -rf "${APP_PATH}/tmp"

rm -rf "${APP_PATH}/8081"
