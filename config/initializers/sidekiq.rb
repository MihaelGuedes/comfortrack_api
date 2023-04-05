require 'sidekiq/web'
require 'sidekiq-cron'

schedule_file = '/config/schedule.yml'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
  config.logger = Logger.new('/dev/null') if Rails.env.test?
end

#Sidekiq::Web.set :session_secret, Rails.application.secret_key_base
# Sidekiq::Web.set :sessions, Rails.application.config.session_options

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key:  Rails.application.secret_key_base

# if File.exist?(schedule_file) && Sidekiq.server?
#   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
# end
