Datadog.configure do |c|
  c.service = 'blog'
  c.env = Rails.env
  c.version = '1.0.0'

  c.tracing.instrument :rails

  c.tracing.instrument :active_record

  c.tracing.instrument :redis
end
