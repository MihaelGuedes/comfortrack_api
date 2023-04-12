class CollarsController < ApplicationController
  before_action :only_user_tutor_access_resource, only: [:index, :update]
  before_action :only_user_tutor_access_resource, only: [:index, :update]
  
  def index
    collars = Collars.where(user_id: current_user.id)
    
    render json: collars, status: :ok
  end

  def create
    @service = Collars::Create.call(user: api_params[:user_id],
                                    name: api_params[:name],
                                    code: api_params[:code])
  end

  def update
    @service = Collars::Update.call(collar_id: params[:id],
                                    name: api_params[:name])

    render_service
  end

  private

  def api_params
    params.permit(:name, :code, :user_id)
  end
end
