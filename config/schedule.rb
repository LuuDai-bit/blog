ENV.each_key do |key|
  env key.to_sym, ENV[key]
end

set :enviroment, ENV["RAILS_ENV"]

# TODO: Move this logic to background service, then uncomment this
# every 1.day, at: '00:00 am' do
#   runner 'GenerateReminderJob.perform_async'
# end

every 1.day, at: '01:00 am' do
  runner 'SyncViewsToPostJob.new.perform'
end

every 1.hour do
  runner 'DeactivateAnnouncementJob.new.perform'
end
