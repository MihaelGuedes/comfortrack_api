class Collars::Update
  prepend SimpleCommand

  def initialize(collar_id:, name:)
    @collar = Collar.find collar_id
    @name = name
  end

  def call
    return @collar if @collar.update(name: @name)

    @user.errors.each { |error| errors.add error.attribute, error.message }
  end
end