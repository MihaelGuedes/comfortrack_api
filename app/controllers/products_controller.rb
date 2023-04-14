class ProductsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :only_user_admin_access_resource, except: %i[index show]

  def index
  end
  
  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def api_params
    params.permit()
  end
end
