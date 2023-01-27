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
end
