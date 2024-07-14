class Blog::RedisClient
  include Blog::Supports::RedisKey

  DEFAULT_DB = 1

  attr_reader :client

  def initialize(db=DEFAULT_DB)
    @client ||= Redis.new(config(db))
  end

  private

  def config(db)
    {
      host: ENV['REDIS_HOST'],
      port: ENV['REDIS_PORT'],
      db: db,
      password: ENV['REDIS_PASSWORD']
    }
  end
end
