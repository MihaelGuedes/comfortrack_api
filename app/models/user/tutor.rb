# == Schema Information
#
# Table name: users
#
# *id*::                    <tt>uuid, not null, primary key</tt>
# *avatar*::                <tt>string</tt>
# *email*::                 <tt>string(200), not null, indexed</tt>
# *name*::                  <tt>string(100), not null</tt>
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
class User::Tutor < User
	after_initialize do
    self.user_type ||= :tutor
  end

  default_scope -> { where(user_type: :tutor) }
end
