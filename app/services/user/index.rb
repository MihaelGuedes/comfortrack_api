class User::Index
  prepend SimpleCommand
  
  def initialize(email, name, user_type)
    @email = email
    @name = name
    @user_type = user_type
    @users = User.all.decorate
  end

  def call
    @users = filter_by_user_type if @email.present?
    @users = filter_by_user_name  if @name.present?
    @users = filter_by_user_email if @user_type.present?

    @users
  end

  private

  def filter_by_user_email
    @users.where(email: @email) 
  end

  def filter_by_user_name
    @users.where(name: @name)
  end

  def filter_by_user_type
    @users.where(user_type: @user_type)
  end
end