class PurchasedProductController < ApplicationController
  def purchase
    @service = Plans::Purchased.call(api_params, current_user)
  
    render_service
  end

  private

  def api_params
    params.permit(:product_id, :promotion)
  end
end
