require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "display_error" do
    class DummyErrorModel
      include ActiveModel::Model
      attr_accessor :name
    end

    it "renders an error feedback div when errors present" do
      model = DummyErrorModel.new
      model.errors.add(:name, "can't be blank")
      html = helper.display_error(model, :name, "Name")

      expect(html).to include("error-feedback")
      expect(html).to include("Name can&#39;t be blank")
    end

    it "returns nil when no errors" do
      model = DummyErrorModel.new
      expect(helper.display_error(model, :name, "Name")).to be_nil
    end
  end

  describe "display_errors_hash" do
    it "renders error when attribute key exists" do
      html = helper.display_errors_hash({ "user" => ["is invalid"] }, :user)
      expect(html).to include("error-feedback")
      expect(html).to include("is invalid")
    end

    it "returns nil when attribute key missing" do
      expect(helper.display_errors_hash({ "user" => ["is invalid"] }, :email)).to be_nil
    end
  end

  describe "toastr_flash" do
    it "renders success script for notice flash" do
      helper.flash[:notice] = "Saved"
      html = helper.toastr_flash
      expect(html).to include("toastr.success('Saved'" )
    end

    it "renders error script for alert flash" do
      helper.flash[:alert] = "Failed"
      html = helper.toastr_flash
      expect(html).to include("toastr.error('Failed'" )
    end

    it "renders custom type script for other flash types" do
      helper.flash[:custom] = "Msg"
      html = helper.toastr_flash
      expect(html).to include("toastr.custom('Msg'" )
    end
  end

  describe "current_controller?" do
    it "checks if current path includes option" do
      allow(helper.request).to receive(:original_fullpath).and_return("/admin/posts")
      expect(helper.current_controller?("posts")).to be true
      expect(helper.current_controller?("users")).to be false
    end
  end

  describe "default_locale?" do
    it "returns true when locale vi" do
      allow(I18n).to receive(:locale).and_return(:vi)
      expect(helper.default_locale?).to be true
    end

    it "returns false for other locales" do
      allow(I18n).to receive(:locale).and_return(:en)
      expect(helper.default_locale?).to be false
    end
  end

  describe "format_datetime" do
    it "formats date objects" do
      date = Date.new(2026, 3, 19)
      expect(helper.format_datetime(date)).to eq("19-03-2026")
    end

    it "returns nil for non-date values" do
      expect(helper.format_datetime(nil)).to be_nil
    end
  end

  describe "display_image" do
    before do
      allow(helper).to receive(:image_tag).and_return("<img src='test' />")
    end

    it "uses given image when file exists" do
      allow(File).to receive(:exist?).and_return(true)
      html = helper.display_image("sample.png", class: "img")
      expect(html).to eq("<img src='test' />")
    end

    it "falls back to no_image when file missing" do
      allow(File).to receive(:exist?).and_return(false)
      html = helper.display_image("sample.png", class: "img")
      expect(html).to eq("<img src='test' />")
    end
  end

  describe "page_theme" do
    it "returns theme value from Setting when present" do
      fake_setting = double("Setting", value: "dark")
      allow(Setting).to receive_message_chain(:where, :first).and_return(fake_setting)
      expect(helper.page_theme).to eq("dark")
    end

    it "returns default when no theme setting" do
      allow(Setting).to receive_message_chain(:where, :first).and_return(nil)
      expect(helper.page_theme).to eq("default")
    end
  end
end