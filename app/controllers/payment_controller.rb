class PaymentController < ApplicationController
  def payments
    @service = PaymentService.call(payment_params, current_user)

    render_service status_success: :created
  end

  private

  def payment_params
    params.permit(
      :paid,
      :type,
      :due_date,
      :card_holder,
      :card_number,
      :expiration_month,
      :expiration_year,
      :security_code,
    )
  end
end
