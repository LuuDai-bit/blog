class Feed
  DOMAIN = ENV['FEED_APP_DOMAIN'] || 'http://localhost:3002'

  class << self
    def list_with_pagination(page, per_page)
      url = "#{DOMAIN}/feeds"
      query = {
        page: page,
        per_page: per_page
      }

      HTTParty.get(url, query: query)
    end

    def mark_as_read(id)
      url = "#{DOMAIN}/feeds/mark_as_read"
      body = { id: id }

      HTTParty.patch(url, body: body.to_json)
    end
  end
end
