module PostsHelper
  def status_badges(status)
    badge = case status.to_sym
            when :draft
              "secondary"
            when :publish
              "success"
            end

    content_tag(:span, status, class: ["badge", "badge-#{badge}"])
  end

  def english_status_badges(post)
    badge = "secondary"
    text = "Not available"

    if post.english_version_available?
      badge = "success"
      text = "Available"
    end

    content_tag(:span, text, class:["badge", "badge-#{badge}"])
  end
end
