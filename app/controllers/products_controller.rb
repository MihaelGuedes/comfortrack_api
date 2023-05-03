class ProductsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :only_user_admin_access_resource, except: %i[create update destroy]

  def index
    products = Products.all

    render json: products
  end
  
  def show
    product = Products.find params[:id]

    render json: product
  end

  def create
    @service = Products::Create.call(api_params)

    render_service
  end

  def update
    @service = Products::Update.call(product_id: params[:id], params: api_params)

    render_service
  end

  def destroy
    product = Products.find params[:id]

    render json: [], status: :no_content if product.delete
  end

  private

  def api_params
    params.permit(:name, :price, :description, :product_type)
  end
end
