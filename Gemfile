source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.7'

gem 'aws-actionmailer-ses'
gem 'aws-sdk-rails'
gem 'aws-sdk-s3', '>= 1.208.0'
gem 'aws-sdk-sns'
gem 'config'
gem 'devise'
gem 'grpc', '~> 1.60'
gem 'grpc-tools', '~> 1.60'
gem 'google-protobuf', '3.25'
gem 'image_processing', '>= 1.12.2'
gem 'jbuilder', '~> 2.11'
gem 'pagy'
gem 'pg'
gem 'prometheus-client'
gem 'puma', '>= 6.4.3'
gem 'rack', '~> 2.2'
gem 'rails', '~> 8.0'
gem 'sass-rails', '>= 6'
gem 'sidekiq', ">= 7.2.4"
gem 'stimulus-rails'
gem 'toastr-rails'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
gem 'whenever', require: false
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'httparty'
gem 'phony_rails'
gem 'rails_icons'
gem 'strong_migrations'
gem 'twilio-ruby'
gem 'lograge'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov_json_formatter'
  gem 'timecop'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
