class Plans::PaymentService
  
  def initialize(payment_params, user)
    @params = payment_params
    @user = user
  end

  def call
    payment = Payment.new(
      type: :credit_card, 
      status: :approved,
      payday: Time.zone.now,
      user: @user,
      due_date: @params[:due_date],  
      card_holder: @params[:card_holder],
      card_number: @params[:card_number],
      expiration_month: @params[:expiration_month],
      expiration_year: @params[:expiration_year],
      security_code: @params[:security_code],
    )

    return [] if payment.save

    payment.errors.each { |error| errors.add error.attribute, error.message }
  end
end
