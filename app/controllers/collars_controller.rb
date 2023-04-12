class CollarsController < ApplicationController
  before_action :only_user_tutor_access_resource
  
  def index
    collars = Collars.where(user_id: current_user.id)
    
    render json: collars, status: :ok
  end

  def update
    @service = Collars::Update.call(collar_id: params[:id],
                                    name: api_params[:name])

    render_service
  end

  private

  def api_params
    params.permit(:name)
  end
end
