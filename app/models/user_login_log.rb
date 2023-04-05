# == Schema Information
#
# Table name: user_login_logs
#
# *id*::            <tt>bigint, not null, primary key</tt>
# *email*::         <tt>string</tt>
# *ip_address*::    <tt>string</tt>
# *last_login_at*:: <tt>datetime</tt>
# *user_agent*::    <tt>string</tt>
# *created_at*::    <tt>datetime, not null</tt>
# *updated_at*::    <tt>datetime, not null</tt>
# *user_id*::       <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_user_login_logs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++

class UserLoginLog < ApplicationRecord
  belongs_to :user

  validates :email, presence: true
  validates :last_login_at, presence: true
  validates :ip_address, presence: true
  validates :user_agent, presence: true
end
