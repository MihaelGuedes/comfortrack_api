class User::Destroy
  prepend SimpleCommand
  
  def initialize(user)
    @user = user
  end

  def call
    return if @user.update(status: :inactive)
    
    @user.errors.each { |error| errors.add error.attribute, error.message }

    nil
  end
end