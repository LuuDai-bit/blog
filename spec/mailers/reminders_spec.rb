require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe "send_notification" do
    let(:email_address) { "user@example.com" }
    let(:title) { "Reminder: Meeting at 3pm" }
    let(:body) { "Don't forget the team sync at 3pm today." }

    subject(:mail) { described_class.send_notification(email_address, title, body) }

    it "renders headers" do
      expect(mail.subject).to eq(title)
      expect(mail.to).to eq([email_address])
      expect(mail.from).to all(be_present)
    end

    it "renders body" do
      expect(mail.body.encoded).to include(body)
    end

    it "delivers mail" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
      delivered = ActionMailer::Base.deliveries.last
      expect(delivered.subject).to eq(title)
      expect(delivered.to).to eq([email_address])
      expect(delivered.body.encoded).to include(body)
    end
  end
end
