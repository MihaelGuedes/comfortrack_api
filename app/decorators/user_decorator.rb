class UserDecorator < ApplicationDecorator
  delegate_all

  def user_type
    I18n.t("enum.user.user_type.#{object.user_type}")
  end
end