module PostsHelper
  require 'nokogiri'

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

  def render_action_text_with_images(content)
    doc = Nokogiri::HTML::DocumentFragment.parse(content)

    doc.css('action-text-attachment').each do |attachment_node|
      url = attachment_node['url']
      if url.blank?
        signed_id = attachment_node['signed_id']
        blob = ActiveStorage::Blob.find_signed(signed_id)
        url = blob.url
      end

      content_type = attachment_node['content-type']

      if url.present? && content_type.match?(/^image\/.*/)
        img_tag = ActionController::Base.helpers.image_tag(url)
        attachment_node.replace(img_tag)
      else
        attachment_node.replace('Unsupported attachment')
      end
    end

    doc.to_html.html_safe
  end
end
