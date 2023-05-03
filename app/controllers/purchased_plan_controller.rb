class PurchasedPlanController < ApplicationController
  def purchased
    @service = Plans::Purchased.call(api_params, current_user)

    render_service
  end

  private

  def api_params
    params.permit(:plan_id, :promotion)
  end
end
