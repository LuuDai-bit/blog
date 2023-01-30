#!/bin/bash

bundle check || bundle install --binstubs="$BUNDLE_BIN"

exec "$@"

whenever --update-crontab --set environment='production'
sudo service cron restart
bundle exec sidekiq -e production
