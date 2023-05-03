class CollarsController < ApplicationController
  before_action :only_user_tutor_access_resource, only: [:index, :update]
  before_action :only_user_admin_access_resource, except: %i[create]
  
  def index
    collars = Collars.where(user_id: current_user.id)

    render json: collars, status: :ok
  end

  def show
    collar = Collars.find params[:id]

    render json: collar, status: :ok
  end

  def create
    @service = Collars::Create.call(user: api_params[:user_id],
                                    code: api_params[:code])
    
    render_service status_success: :created
  end

  def update
    @service = Collars::Update.call(collar_id: params[:id],
                                    name: api_params[:name])

    render_service
  end

  def destroy
    collar = Collar.find params[:id]

    render json: [], status: :no_content if collar.delete
  end

  private

  def api_params
    params.permit(:name, :code, :user_id)
  end
end
