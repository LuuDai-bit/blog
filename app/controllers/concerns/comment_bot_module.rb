module CommentBotModule
  DOMAIN = ENV['GITHUB_APP_DOMAIN'] || 'http://localhost:3000'

  def push_github_comment
    url = "#{CommentBotModule::DOMAIN}/api/v1/comments"
    response = HTTParty.post(url, body: body)

    response
  end

  def get_comment_templates(page = 1, per_page = 20)
    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates"
    body = {
      page: page,
      per_page: per_page
    }.to_json
    response = HTTParty.get(url, body: body)

    response
  end

  def create_comment_templates(message)
    return if message.blank?
  end
end
