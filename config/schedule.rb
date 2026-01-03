ENV.each_key do |key|
  env key.to_sym, ENV[key]
end

set :enviroment, ENV["RAILS_ENV"]

every 1.day, at: '00:00 am' do
  runner 'GenerateReminderJob.perform_async'
end

every 1.day, at: '01:00 am' do
  runner 'SyncViewsToPostJob.perform_async'
end

every 1.hour do
  runner 'DeactivateAnnouncementJob.perform_async'
end
