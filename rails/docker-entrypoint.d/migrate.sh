#!/bin/sh

bundle exec rake db:migrate 2>/dev/null
echo "Ran DB Migrations!"
