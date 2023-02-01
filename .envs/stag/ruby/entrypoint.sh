#!/bin/bash

bundle check || bundle install --binstubs="$BUNDLE_BIN"

whenever --update-crontab --set
sudo service cron restart
bundle exec sidekiq -e production

exec "$@"
