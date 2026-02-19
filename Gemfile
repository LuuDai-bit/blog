source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.7'

gem 'rails', '7.1.5.2'
gem 'rack', '~> 2.2'
gem 'puma', '>= 6.4.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'pg'
gem 'pagy'
gem 'image_processing', '>= 1.12.2'
gem 'devise'
gem 'stimulus-rails'
gem 'aws-sdk-s3', '>= 1.208.0'
gem 'aws-sdk-sns'
gem 'aws-sdk-rails'
gem 'aws-actionmailer-ses'
gem 'config'
gem 'whenever', require: false
gem 'sidekiq', ">= 7.2.4"
gem 'toastr-rails'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'strong_migrations'
gem 'rails_icons'
gem 'twilio-ruby'
gem 'phony_rails'
gem 'httparty'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'pry'
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'simplecov_json_formatter'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
