class PlansController < ApplicationController

  def index
    plans = Plan.all.unscopped

    render json: plans, status: :ok
  end

  def show
    plan = Plan.find params[:id]

    render json: plan, status: :ok if plan.present?
  end

  def create
    @service = Plans::Create.call(name: api_params[:name],
                                  price: api_params[:price],
                                  type_plan: api_params[:type_plan],
                                  months: api_params[:mounts])

    render_service
  end

  def update
    @service = Plans::Update.call(plan_id: params[:id], params: api_params)

    render_service
  end

  def delete
    plan = Plan.find params[:id]

    render json: [], status: :no_content if plan.delete
  end

  private

  def api_params
    params.permit(:name, :price, :type_plan, :mounts)
  end
end
