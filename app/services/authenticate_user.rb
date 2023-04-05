class AuthenticateUser
  prepend SimpleCommand
  include ActiveModel::Validations

  # optional, initialize the command with some arguments
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.jwt_encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email:)
    return user if user&.authenticate(password)

    errors.add :base, :failure
    nil
  end
end