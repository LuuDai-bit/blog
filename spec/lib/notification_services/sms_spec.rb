require "rails_helper"
require "notification_services/sms"

RSpec.describe NotificationServices::SMS, type: :model do
  let(:destination) { "+14155552671" }
  subject(:service) { described_class.new(destination) }

  describe "send_notification" do
    let(:recipient) { "user" }
    let(:body) { "Hello world" }

    before do
      stub_const("ENV", ENV.to_hash.merge({
        "TWILIO_PHONE_NUMBER" => "+14155550000",
        "TWILIO_ACCOUNT_SID" => "sid",
        "TWILIO_AUTH_TOKEN" => "token"
      }))
    end

    it "raises when destination is not eligible" do
      allow(service).to receive(:eligible?).with(destination).and_return(false)
      expect { service.send_notification(recipient, body) }.to raise_error(RuntimeError, /Destination not eligible for Twilio notifications/)
    end

    it "sends with Twilio client when eligible" do
      allow(service).to receive(:eligible?).with(destination).and_return(true)
      messages = double("messages")
      twilio_client = double("twilio_client", messages: messages)
      created_message = double("message", sid: "SM12345")

      expect(Twilio::REST::Client).to receive(:new).with("sid", "token").and_return(twilio_client)
      expect(messages).to receive(:create).with(
        body: body,
        to: "whatsapp:#{destination}",
        from: "whatsapp:+14155550000"
      ).and_return(created_message)

      sid = service.send_notification(recipient, body)
      expect(sid).to eq("SM12345")
    end
  end

  describe "eligible?" do
    it "uses Phony.plausible?" do
      expect(Phony).to receive(:plausible?).with(destination).and_return(true)
      expect(service.send(:eligible?, destination)).to be true
    end
  end
end