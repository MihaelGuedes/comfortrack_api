# frozen_string_literal: true

class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || (errors.add(:token, :failure) && nil)
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.jwt_decode(http_auth_header)
  rescue JWT::ExpiredSignature
    errors.add(:token, :expired)
  end

  def http_auth_header
    headers['Authorization'].present? ? headers['Authorization'].split.last : errors.add(:token, :invalid )
  end
end