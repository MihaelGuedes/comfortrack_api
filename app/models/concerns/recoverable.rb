module Recoverable
  extend ActiveSupport::Concern

  def reset_password_instruction
    save_token_and_expiry
    send_reset_password_instructions
  end

  def save_token_and_expiry
    token = SecureRandom.urlsafe_base64(18, false)
    update(password_reset_token: token, password_token_expiry: 3.hours.from_now)
  end

  def reset_password(new_password, new_password_confirmation)
    if new_password.present? & reset_password_period_valid?
      set_new_password(new_password, new_password_confirmation)
    else
      errors.add(:password, :blank)
      false
    end
  end

  def set_new_password(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    return false unless save
    clear_reset_password_token!
    true
  end

  def send_reset_password_instructions
    token = password_reset_token
    send_reset_password_instructions_notification(token)
    token
  end

  def reset_password_period_valid?
    password_token_expiry && password_token_expiry.utc > Time.now.utc
  end

  protected

  def clear_reset_password_token!
    update(password_reset_token: nil, password_token_expiry: nil)
  end

  def send_reset_password_instructions_notification(token)
    # SendPasswordResetWorker.perform_async(id, token)
  end
end