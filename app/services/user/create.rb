class User::Create
  prepend SimpleCommand
  
  def initialize(create_user_params)
    @params = create_user_params
  end

  def call
    create
  end

  private

  def create
    user = User.new(@params)

    unless user.save
      user.errors.each { |error| errors.add error.attribute, error.message }
    end

    errors.presence || user
  end
end