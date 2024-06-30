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
