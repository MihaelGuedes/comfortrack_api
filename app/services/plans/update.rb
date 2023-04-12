class Plans::Update
  prepend SimpleCommand

  def initialize(plan_id:, params:)
    @plan = Plan.find plan_id
    @params = params
  end

  def call
    return @plan if @plan.update(@params)

    @plan.errors.each { |error| errors.add error.attribute, error.message }
  end
end