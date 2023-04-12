class Plans::Create
  prepend SimpleCommand

  def initialize(name:, price:, type_plan:, months:)
    @name = name
    @price = price
    @type_plan = type_plan
    @months = months
  end

  def call
    plan = Plan.new(
      name: @name,
      price: @price,
      type_plan: @type_plan,
      mounts: @months,
    )

    return plan if plan.save

    plan.errors.each { |error| errors.add error.attribute, error.message }
  end
end
