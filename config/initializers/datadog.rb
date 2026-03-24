Datadog.configure do |c|
  c.service = 'my-rails-app'   # your app name
  c.env = Rails.env
  c.version = '1.0.0'

  # Enable Rails tracing
  c.tracing.instrument :rails

  # Optional: ActiveRecord
  c.tracing.instrument :active_record

  # Optional: Redis
  c.tracing.instrument :redis
end
