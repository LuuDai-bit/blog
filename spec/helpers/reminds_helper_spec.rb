require "rails_helper"

RSpec.describe RemindsHelper, type: :helper do
  describe "day_format" do
    it "joins day values with comma and space" do
      expect(helper.day_format(["Mon", "Wed", "Fri"])).to eq("Mon, Wed, Fri")
    end
  end

  describe "selected_day" do
    before do
      allow(Settings.models.reminder.day).to receive(:to_h).and_return({
        "0" => "Mon",
        "1" => "Tue",
        "2" => "Wed"
      })
    end

    it "returns first configured key when day is blank" do
      expect(helper.selected_day(nil)).to eq("0")
      expect(helper.selected_day([])).to eq("0")
      expect(helper.selected_day("")).to eq("0")
    end

    it "returns key when day matches value exactly" do
      expect(helper.selected_day("Tue")).to eq("1")
    end

    it "returns selected keys when day includes values" do
      expect(helper.selected_day(["Mon", "Wed"]).sort).to eq(["0", "2"])
    end

    it "returns nil when no match is found" do
      expect(helper.selected_day(["Thu"])).to be_nil
    end
  end
end