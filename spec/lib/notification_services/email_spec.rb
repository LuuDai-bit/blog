require "rails_helper"
require "notification_services/email"

RSpec.describe NotificationServices::Email, type: :model do
  let(:destination) { "user@example.com" }
  subject(:service) { described_class.new(destination) }

  describe "send_notification" do
    let(:recipient) { "user@example.com" }
    let(:message) { "Hello from the reminder system" }

    it "delivers via ReminderMailer when address is valid" do
      mail = double("Mail", deliver_later: true)
      expect(ReminderMailer).to receive(:send_notification).with(recipient, recipient, message).and_return(mail)

      expect { service.send_notification(recipient, message) }.not_to raise_error
    end

    it "raises ArgumentError for invalid recipient" do
      expect { service.send_notification("not-an-email", message) }.to raise_error(ArgumentError, /Invalid email address/)
    end
  end

  describe "eligible?" do
    it "returns true for valid email" do
      expect(service.send(:eligible?, "user@example.com")).to be true
    end

    it "returns false for invalid email" do
      expect(service.send(:eligible?, "foo")).to be false
    end
  end
end