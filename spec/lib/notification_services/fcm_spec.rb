require "rails_helper"
require "notification_services/fcm"

RSpec.describe NotificationServices::FCM, type: :model do
  let(:destination) { "device-token-123" }
  subject(:service) { described_class.new(destination) }

  describe "send_notification" do
    let(:recipient) { "user-device" }
    let(:message) { "Hello FCM" }

    it "raises when destination is not eligible" do
      allow(service).to receive(:eligible?).with(destination).and_return(false)
      expect { service.send_notification(recipient, message) }.to raise_error(RuntimeError, /Destination not eligible for FCM notifications/)
    end

    it "sends when destination is eligible" do
      allow(service).to receive(:eligible?).with(destination).and_return(true)
      expect { service.send_notification(recipient, message) }.to output(/Sending FCM notification to #{recipient}: #{message}/).to_stdout
    end
  end

  describe "eligible?" do
    it "returns nil by default (unimplemented)" do
      expect(service.send(:eligible?, destination)).to be_nil
    end
  end
end