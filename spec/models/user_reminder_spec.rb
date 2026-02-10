# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserReminder, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:reminder) }
  end

  describe 'callbacks' do
    context 'after_create' do
      before { Timecop.freeze(Time.zone.local(2026, 2, 9, 10, 0, 0)) } # Monday
      after { Timecop.return }

      context 'schedule_reminder_init' do
        let(:user) { FactoryBot.create(:user) }
        let(:reminder_params) do
          {
            title: 'Test Reminder',
            content: 'This is a test reminder.',
            target_date: Time.now.since(1.hour),
            day: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
          }
        end
        let(:reminder) { FactoryBot.create(:reminder, reminder_params) }

        before { allow(ExecuteReminderJob).to receive(:perform_at) }

        it 'should enqueue excute reminder job at the correct time' do
          FactoryBot.create(:user_reminder, user: user, reminder: reminder)

          expect(ExecuteReminderJob).to have_received(:perform_at)
        end

        it 'should not enqueue excute reminder job if the day is not included' do
          reminder_params[:day] = ['Sat', 'Sun']
          FactoryBot.create(:user_reminder, user: user, reminder: reminder)

          expect(ExecuteReminderJob).not_to have_received(:perform_at)
        end
      end
    end
  end
end
