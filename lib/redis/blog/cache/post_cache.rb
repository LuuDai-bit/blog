class Blog::Cache::PostCache
  include Blog::Supports::RedisKey

  def fetch_post_cached(post_id, locale)
    key = redis.post_cached(post_id, locale)
    post_str = redis.client.get(key)

    post_str.present? ? JSON.parse(post_str) : nil
  end

  def fetch_cache_lock(post_id, locale)
    key = redis.post_caching(post_id, locale)
    redis.client.get(key)
  end

  def set_post_cache(post_id, locale)
    key = redis.post_caching(post_id, locale)
    redis.client.set(key, 1) unless redis.client.get(key)

    post = Post.by_locale.find(post_id)
    redis.client.set(redis.post_cached(post_id, locale), cached_object(post, locale), ex: 120)

    redis.client.del(key)

    JSON.parse(cached_object(post, locale))
  end

  def update_views
  end

  def destroy_cache(post_id)
    locales = [:en, :vi]
    locales.each do |locale|
      key = redis.post_cached(post_id, locale)

      redis.client.del(key)
    end
  end

  private

  def redis
    @redis ||= Blog::RedisClient.new
  end

  def cached_object(post, locale)
    obj = if locale.to_s == 'vi'
            {
              subject: post.subject,
              content: post.content
            }
          else
            {
              subject_en: post.subject_en,
              content_en: post.content_en
            }
          end

    obj.merge!(id: post.id,
               created_at: post.created_at,
               english_version_available: post.english_version_available?)

    obj.to_json
  end
end
