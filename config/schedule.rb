env :PATH, ENV['PATH']

every 1.day, at: '00:00 am' do
  runner 'GenerateReminderJob.perform_async'
end
