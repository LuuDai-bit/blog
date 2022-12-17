#!/bin/bash

/scripts/wait-for-it.sh mysql:3306 --timeout=300 -- echo 'Mysql service is ready!'

rm -f tmp/pids/server.pid

bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 3000
