class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  authorize_resource :user, only: %i[index show update destroy]
  before_action :set_user, only: %i[show update destroy]

  def index
    @service = User::Index.call(api_params[:email], api_params[:name], api_params[:user_type])

    render json: paginate(@service.result), status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @service = User::Create.call(create_user_params)

    render_service status_success: :created
  end

  def update
    @service = User::Update.call(@user, update_user_params)

    render_service
  end

  def destroy
    @service = User::Destroy.call(@user)

    render_service status_success: :no_content
  end

  private

  def update_user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def create_user_params
    params.require(:user).permit(:name, :email, :phone, :avatar,
                                  :user_type, :password, :password_confirmation,
                                  :status, permission_ids: []
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def api_params
    params.permit(:email, :name, :user_type)
  end
end
