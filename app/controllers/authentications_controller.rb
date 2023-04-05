class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request
  after_action :user_login_log

  def authenticate_user
    @authentication = AuthenticateUser.call(authentication_params[:email], authentication_params[:password])

    if @authentication.success?
      render json: { auth_token: @authentication.result }, status: :ok
    else
      render json: { error: @authentication.errors }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params.require(:auth_user).permit(:email, :password)
  end

  def user_login_log
    return unless @authentication.success?
    email = authentication_params[:email] || @authentication.user.email

    login_infos = JsonWebToken.jwt_decode(@authentication.result)
    user_login_log = UserLoginLog.new(user_id: login_infos[:user_id], email:,
      last_login_at: Time.zone.now, ip_address: request.remote_ip, user_agent: request.user_agent
    )
    user_login_log.save!
  end
end
