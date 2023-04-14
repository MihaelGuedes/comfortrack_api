class Collars::Create
  prepend SimpleCommand

  def initialize(user:, name:, code:)
    @user = user
    @name = name
    @code = code
  end

  def call
    collar = Collar.new(
      code: @code,
      user_id: @user_id,
    )

    collar.name = collar.id.split('-').first if collar.save
    return collar if collar.save

    collar.errors.each { |error| errors.add error.attribute, error.message }
  end
end
