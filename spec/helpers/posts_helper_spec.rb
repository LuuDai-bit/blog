require "rails_helper"

RSpec.describe PostsHelper, type: :helper do
  describe "status_badges" do
    it "renders draft badge" do
      html = helper.status_badges(:draft)
      expect(html).to include("Draft")
      expect(html).to include("badge-secondary")
    end

    it "renders publish badge" do
      html = helper.status_badges("publish")
      expect(html).to include("Publish")
      expect(html).to include("badge-success")
    end
  end

  describe "english_status_badges" do
    let(:post) { instance_double("Post") }

    it "shows not available when english_version_available? is false" do
      allow(post).to receive(:english_version_available?).and_return(false)
      html = helper.english_status_badges(post)

      expect(html).to include("Not available")
      expect(html).to include("badge-secondary")
    end

    it "shows available when english_version_available? is true" do
      allow(post).to receive(:english_version_available?).and_return(true)
      html = helper.english_status_badges(post)

      expect(html).to include("Available")
      expect(html).to include("badge-success")
    end
  end

  describe "render_action_text_with_images" do
    it "converts image attachment tags with url to img tag" do
      given = '<p>Hello</p><action-text-attachment url="/path/to/image.png" content-type="image/png"></action-text-attachment>'
      output = helper.render_action_text_with_images(given)

      expect(output).to include('<img')
      expect(output).to include('src="/path/to/image.png"')
    end

    it "converts attachment tags without url but with signed_id to img tag" do
      blob = instance_double("ActiveStorage::Blob", url: "/signed-image.png")
      allow(ActiveStorage::Blob).to receive(:find_signed).with("signed-id-1").and_return(blob)

      given = '<action-text-attachment signed_id="signed-id-1" content-type="image/png"></action-text-attachment>'
      output = helper.render_action_text_with_images(given)

      expect(output).to include('<img')
      expect(output).to include('src="/signed-image.png"')
    end

    it "replaces unsupported attachment type with text" do
      given = '<action-text-attachment url="/path/to/file.pdf" content-type="application/pdf"></action-text-attachment>'
      output = helper.render_action_text_with_images(given)

      expect(output).to include("Unsupported attachment")
      expect(output).not_to include("<img")
    end
  end
end