class Plans::Purchased
  prepend SimpleCommand

  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    plan = take_plan

    purchased_plan = PurchasedPlan.new(
      name: plan.name,
      price: plan.price,
      type_plan: plan.type_plan,
      mounts: plan.months,
      due_date: take_due_date(plan),
      user: @user,
      promotion: @params[:promotion],
      status: :paid,
      plan:,
    )

    return purchased_plan if purchased_plan.save

    purchased_plan.errors.each { |error| errors.add error.attribute, error.message }
  end

  private

  def take_plan
    Plan.find @params[:plan_id]
  end

  def take_due_date(plan)
    count_days = plan.mounts * 30

    Time.zone.today + count_days.days
  end
end