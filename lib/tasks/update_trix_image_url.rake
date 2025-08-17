# frozen_string_literal: true

# Update rails may cause the image url change (hash algorithm change from SHA1 to SHA256).
# This file is used when I want to update url
namespace :update_trix_image_url do
  desc 'Update trix image url'

  task migrate: :environment do
    def self.refresh_trix(trix)
      return unless trix.embeds.size.positive?

      trix.body.fragment.find_all("action-text-attachment").each do |node|
        embed = trix.embeds.find { |attachment| attachment.filename.to_s == node["filename"] && attachment.byte_size.to_s == node["filesize"] }

        node.attributes["url"].value = Rails.application.routes.url_helpers.rails_storage_redirect_url(embed.blob, host: "YOUR_DOMAIN")
        node.attributes["sgid"].value = embed.attachable_sgid
      end

      trix.update_column :body, trix.body.to_s
    end

    ActionText::RichText.where.not(body: nil).find_each do |trix|
      refresh_trix(trix)
    end
  end
end

# Update for temporary image trix < 1.3.0
# include Rails.application.routes.url_helpers

# Post.find_each do |post|
#   remote_images = post.content.body.attachables.select { |a| a.is_a?(ActionText::Attachables::RemoteImage) }

#   p 'a' if remote_images.empty?
#   next if remote_images.empty?

#   updated_body = post.content.body
#   doc = Nokogiri::HTML::DocumentFragment.parse(updated_body.to_html)
#   embeds = post.content.embeds

#   index = 0
#   remote_images.each do |remote|
#     node = doc.css("action-text-attachment[url='#{remote.url}']").first

#     return if node.blank?

#     # Create and upload a new blob
#     blob = embeds[index]&.blob

#     next if blob.blank?

#     attachment = ActionText::Attachment.from_attachable(blob).to_html

#     p attachment

#     # Replace old <action-text-attachment sgid=...> with new blob's attachment HTML
#     new_node = Nokogiri::HTML::DocumentFragment.parse(attachment).children.first
#     new_node['signed_id'] = blob.signed_id
#     node.replace(new_node)

#     index += 1
#   end

#   post.content = doc.to_html
#   post.save!
# end
