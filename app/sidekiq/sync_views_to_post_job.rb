class SyncViewsToPostJob
  # TODO: Deprecated. Will remove before the sidekiq service terminated
  include Sidekiq::Job

  def perform
    # TODO: Deprecated. Will remove before the sidekiq service terminated
    view_hash = redis.client.hgetall(redis.post_views)

    update_attr = []
    Post.where(id: view_hash.keys).find_in_batches do |posts|
      posts.each do |post|
        post.views += view_hash[post.id.to_s].to_i
        update_attr << post.attributes
      end

      Post.upsert_all(update_attr)
    end

    redis.client.del(redis.post_views)

    JobLog.create(job_name: self.class.name)

    # Newly job service. Testing
    params = {
      name: "sync_views_to_post",
      post_views_key: redis.post_views
    }
    RedisModel.Event.create(queue: 'default_jobs', parmas: params)
  end

  private

  def redis
    @redis ||= Blog::RedisClient.new
  end
end
