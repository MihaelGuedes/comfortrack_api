# == Schema Information
#
# Table name: users
#
# *id*::                    <tt>uuid, not null, primary key</tt>
# *avatar*::                <tt>string</tt>
# *email*::                 <tt>string(200), not null, indexed</tt>
# *first_name*::            <tt>string(100), not null</tt>
# *last_name*::             <tt>string(100), not null</tt>
# *password_digest*::       <tt>string, not null</tt>
# *password_reset_token*::  <tt>string</tt>
# *password_token_expiry*:: <tt>datetime</tt>
# *phone*::                 <tt>string</tt>
# *status*::                <tt>integer, default("active"), not null</tt>
# *user_type*::             <tt>string(100), not null</tt>
# *created_at*::            <tt>datetime, not null</tt>
# *updated_at*::            <tt>datetime, not null</tt>
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#--
# == Schema Information End
#++
class User < ApplicationRecord

  self.implicit_order_column = :created_at

  include Recoverable

  enum status: { active: 0, inactive: 1 }

  has_secure_password

  has_many :user_permissions, class_name: 'UserPermission', dependent: :destroy
  has_many :permissions, through: :user_permissions

  TYPES_USER = %w[admin api tutor suporte].freeze
  TYPES_AUTHENTICABLE = %w[admin tutor suporte].freeze

  validates :password, length: { minimum: 6, if: -> { password.present? } }
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, on: :create }, uniqueness: true
  validates :user_type, presence: true, inclusion: { in: TYPES_USER }

  before_validation :downcase_email, :strip_email

  def admin?
    user_type == 'admin'
  end

  def api?
    user_type == 'api'
  end
  
  def tutor?
    user_type == 'tutor'
  end

  def suporte?
    user_type == 'suporte'
  end

  def permission_ids
    permissions.pluck(:id)
  end

  def permissions
    return GroupPolicy.admin.first.permissions if admin?
    return GroupPolicy.tutor.first.permissions if tutor?

    raise "tipo de usuário inválido (#{user_type})"
  end

  def authenticable?
    TYPES_AUTHENTICABLE.include?(user_type)
  end

  def self.parameterize_user_api
    password = SecureRandom.base64(10)
    prefix = Time.zone.now.strftime('%Y%m%d%H%M%S%L')
    user_api_params(password, prefix)
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def strip_email
    self.email = email.strip if email.present?
  end

  def user_api_params(password, prefix)
    {
      name: prefix.to_s,
      email: "api_user_#{prefix}@internal#{prefix}.com.br",
      password:,
      password_confirmation: password,
      user_type: 'api',
    }
  end
end


