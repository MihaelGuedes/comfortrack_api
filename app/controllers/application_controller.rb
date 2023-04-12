class ApplicationController < ActionController::API
  include PaginationHelper
  include CanCan::ControllerAdditions
  before_action :authenticate_request
  attr_reader :current_user

  rescue_from CanCan::AccessDenied do |_e|
    forbidden_error!
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.message }, status: :bad_request
  end

  def append_info_to_payload(payload)
    super
    new_payload = { host: request.host, ip:  request.ip, remote_ip: request.remote_ip,
                    x_forwarded_for: request.env['HTTP_X_FORWARDED_FOR'], current_user_email:, current_user_id:
    }

    payload.merge!(new_payload)
  end

  def render_service(status_success: :ok, status_error: :unprocessable_entity)
    if @service.success?
      render json: @service.result, status: status_success
    else
      render json: @service.errors.full_messages, status: status_error
    end
  end

  def only_user_tutor_access_resource
    return if current_user.tutor?
    
    forbidden_error!
  end

  def only_user_admin_access_resource
    return if current_user.admin?
    
    forbidden_error!
  end

  private

  def current_user_email
    current_user.email
  rescue StandardError
    'No User'
  end

  def current_user_id
    current_user.id
  rescue StandardError
    'No User'
  end

  def authenticate_request
    command = AuthorizeApiRequest.call(request.headers)
    @current_user = command.result
    render json: { error: command.errors }, status: :unauthorized unless @current_user
  end

  def forbidden_error!
    render json: ['Você não tem autorização para acessar este recurso'], status: :forbidden
  end
end
