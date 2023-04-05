# frozen_string_literals: true

require 'colorized_string'

class ColorKeyValue < Lograge::Formatters::KeyValue

  FIELDS_COLORS = {
    action: [:green],
    controller: [:green],
    current_user_email: [:light_blue],
    current_user_id: [:light_green],
    db: [:magenta],
    duration: [:magenta],
    exception: [:light_yellow],
    exception_backtrace: [:light_red],
    exception_message: [:light_magenta, :light_cyan, :italic],
    format: [:red],
    host: [:red],
    ip: [:blue],
    method: [:red],
    params: [:green],
    path: [:red],
    rails_env: [:light_green, :white, :underline],
    status: [:yellow],
    time: [:cyan],
    view: [:magenta],
  }.freeze

  def format(key, value)
    line = super(key, value)

    color = FIELDS_COLORS[key].is_a?(Array) ? FIELDS_COLORS[key][0] : :default
    background = FIELDS_COLORS[key].is_a?(Array) && (FIELDS_COLORS[key].length > 1) ? FIELDS_COLORS[key][1] : :default
    mode = FIELDS_COLORS[key].is_a?(Array) && (FIELDS_COLORS[key].length > 2) ? FIELDS_COLORS[key][2] : :default
    ColorizedString.new(line).colorize(color:, background:, mode:)
  end
end

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = 'ActionController::API'
  config.lograge.formatter = ColorKeyValue.new
  config.lograge.custom_options = lambda do |event|
    {
      application: Rails.app_class.to_s.split('::')[0],
      host: event.payload[:host],
      current_user_email: event.payload[:current_user_email],
      current_user_id: event.payload[:current_user_id],
      rails_env: Rails.env,
      process_id: Process.pid,
      request_id: event.payload[:headers]['action_dispatch.request_id'],
      request_time: Time.zone.now,
      remote_ip: event.payload[:remote_ip],
      ip: event.payload[:ip],
      x_forwarded_for: event.payload[:x_forwarded_for],
      agent: event.payload[:headers].env['HTTP_USER_AGENT'],
      params: event.payload[:params].except(:exceptions).to_json,
      exception: event.payload[:exception]&.first,
      exception_message: event.payload[:exception]&.last.to_s,
      exception_backtrace: event.payload[:exception_object]&.backtrace&.join(','),
    }.compact
  end
end