module CommentBotModule
  DOMAIN = ENV['GITHUB_APP_DOMAIN'] || 'http://localhost:3000'

  def push_github_comment
    url = "#{CommentBotModule::DOMAIN}/api/v1/comments"
    response = HTTParty.post(url, body: body)

    response
  end

  def get_comment_templates(page = 1, per_page = 20)
    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates"
    query = {
      page: page,
      per_page: per_page
    }
    HTTParty.get(url, query: query)
  end

  def create_comment_templates(content, repository_id, status)
    return if content.blank?

    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates"
    body = {
      comment_template: {
        content: content,
        repository_id: repository_id,
        status: status
      }
    }
    HTTParty.post(url, body: body)
  end

  def get_comment_template(id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates/#{id}"
    HTTParty.get(url)
  end

  def update_comment_template(id, content, repository_id, status)
    return if content.blank?

    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates/#{id}"
    body = {
      comment_template: {
        content: content,
        repository_id: repository_id,
        status: status
      }
    }
    HTTParty.patch(url, body: body)
  end

  def destroy_comment_template(id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates/#{id}"
    HTTParty.delete(url)
  end

  def mark_comment_template_as_active(id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/comment_templates/#{id}/make_active"
    HTTParty.patch(url)
  end

  def get_repositories
    url = "#{CommentBotModule::DOMAIN}/api/v1/repositories"
    HTTParty.get(url)
  end

  def get_repositories_with_pagination(page = 1, per_page = 20)
    url = "#{CommentBotModule::DOMAIN}/api/v1/repositories"
    query = {
      page: page,
      per_page: per_page
    }
    HTTParty.get(url, query: query)
  end

  def get_repository(id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/repositories/#{id}"
    HTTParty.get(url)
  end

  def create_respository(owner, name)
    url = "#{CommentBotModule::DOMAIN}/api/v1/repositories"
    body = {
      repository: {
        owner: owner,
        name: name
      }
    }
    HTTParty.post(url, body: body)
  end

  def get_variables(repository_id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/variables"
    query = {
      repository_id: repository_id
    }
    HTTParty.get(url, query: query)
  end

  def create_variable(name, format, repository_id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/variables"
    body = {
      variable: {
        name: name,
        format: format,
        repository_id: repository_id
      }
    }
    HTTParty.post(url, body: body)
  end

  def update_variable(id, name, format, repository_id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/variables/#{id}"
    body = {
      variable: {
        name: name,
        format: format,
        repository_id: repository_id
      }
    }
    HTTParty.patch(url, body: body)
  end

  def destroy_variable(id)
    url = "#{CommentBotModule::DOMAIN}/api/v1/variables/#{id}"
    HTTParty.delete(url)
  end
end
