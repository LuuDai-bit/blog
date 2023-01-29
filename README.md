# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

Ruby 3.0.9
Rails 6
* System dependencies

* Configuration

copy .env and .env.docker 
* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

bundle exec sidekiq
whenever --update-crontab
sudo service cron reload

Cron log: sudo tail -f /var/log/syslog
* Deployment instructions

rake assets:clean && rake assets:precompile 
* ...
