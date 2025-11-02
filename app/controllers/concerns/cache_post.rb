module CachePost
  def cached_and_show
    cached_post = Blog::Cache::PostCache.new.fetch_post_cached(params[:id], I18n.locale)
    raise ActiveRecord::RecordNotFound if cached_post == 'No content'

    cached_post = Blog::Cache::PostCache.new.set_post_cache(params[:id], I18n.locale) if cached_post.blank?

    cache_post_key = Blog::Cache::PostCache.new.fetch_cache_lock(params[:id], I18n.locale)

    while cache_post_key.present? && cached_post.blank?
      cache_post_key = Blog::Cache::PostCache.new.fetch_cache_lock(params[:id], I18n.locale)
      cached_post = Blog::Cache::PostCache.new.fetch_post_cached(params[:id], I18n.locale)
    end

    @post = cached_post
    Blog::Cache::PostCache.new.update_views(params[:id])
  end
end
