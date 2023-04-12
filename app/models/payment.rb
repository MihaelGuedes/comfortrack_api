# == Schema Information
#
# Table name: payments
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *paid*::       <tt>boolean</tt>
# *payday*::     <tt>datetime</tt>
# *status*::     <tt>integer</tt>
# *type*::       <tt>integer</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
# *plan_id*::    <tt>bigint, not null, indexed</tt>
# *user_id*::    <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_payments_on_plan_id  (plan_id)
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :paid, presence: true
  validates :status, presence: true
  validates :type, presence: true

  # TODO: inserir dados de pagamento
end
