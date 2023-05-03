# == Schema Information
#
# Table name: payments
#
# *id*::               <tt>bigint, not null, primary key</tt>
# *card_holder*::      <tt>string</tt>
# *card_number*::      <tt>string</tt>
# *due_date*::         <tt>date</tt>
# *expiration_month*:: <tt>string</tt>
# *expiration_year*::  <tt>string</tt>
# *paid*::             <tt>boolean</tt>
# *payday*::           <tt>datetime</tt>
# *security_code*::    <tt>string</tt>
# *status*::           <tt>integer</tt>
# *type*::             <tt>integer</tt>
# *created_at*::       <tt>datetime, not null</tt>
# *updated_at*::       <tt>datetime, not null</tt>
# *user_id*::          <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class Payment < ApplicationRecord
  belongs_to :user

  enum type: { credit_card: 0, debit_card: 1  }
  enum status: { approved: 0, dissaproved: 1  }

  has_secure_password :security_code

  validates :payday, presence: true
  validates :type, presence: true
  validates :due_date, presence: true
  validates :card_holder, presence: true
  validates :card_number, presence: true
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :security_code, presence: true
end
