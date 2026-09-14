class Blog::Cache::PostProxy
  extend Cache
  include Blog::Supports::RedisKey

  class << self
    def show(post_id, locale)
      key = redis.post_cached(post_id, locale)
      post_str = redis.client.get(key)

      raise ActiveRecord::RecordNotFound if post_str == 'No content'

      if post_str.present?
        JSON.parse(post_str)
      else
        cached_post = set_post_cache(post_id, locale)
        cached_post_key = fetch_cache_lock(post_id, locale)

        while cached_post_key.present? && cached_post.blank?
          cached_post_key = Blog::Cache::PostCache.new.fetch_cache_lock(post_id, locale)
          cached_post = Blog::Cache::PostCache.new.fetch_post_cached(post_id, locale)
        end

        update_views(post_id)

        return cached_post
      end
    end

    def fetch_post_cached(post_id, locale)
      key = redis.post_cached(post_id, locale)
      post_str = redis.client.get(key)

      return post_str if post_str == 'No content'

      post_str.present? ? JSON.parse(post_str) : nil
    end

    def fetch_cache_lock(post_id, locale)
      key = redis.post_caching(post_id, locale)
      redis.client.get(key)
    end

    def set_post_cache(post_id, locale)
      key = redis.post_caching(post_id, locale)
      redis.client.set(key, 1) unless redis.client.get(key)

      post = Post.show(post_id)
      if post.blank?
        redis.client.set(redis.post_cached(post_id, locale), 'No content', ex: 120)

        raise ActiveRecord::RecordNotFound
      else
        redis.client.set(redis.post_cached(post_id, locale), cached_object(post, locale), ex: 120)
      end

      redis.client.del(key)

      JSON.parse(cached_object(post, locale))

    rescue StandardError => e
      redis.client.del(key)
      raise e
    end

    def update_views(post_id)
      hash_key = redis.post_views
      redis.client.hincrby(hash_key, post_id, 1)
    end

    def destroy_cache(post_id)
      locales = [:en, :vi]
      locales.each do |locale|
        key = redis.post_cached(post_id, locale)

        redis.client.del(key)
      end
    end
  end

  private

  attr_reader :post_id, :locale

  class << self
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
end
