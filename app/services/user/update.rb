class User::Update
  prepend SimpleCommand
  
  def initialize(user, update_user_params)
    @user = user
    @params = update_user_params
  end

  def call
    create
  end

  private

  def create
    unless @user.update(@params)
      @user.errors.each { |error| errors.add error.attribute, error.message }
    end

    errors.presence || @user
  end
end