# == Schema Information
#
# Table name: purchased_plans
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *due_date*::   <tt>date</tt>
# *months*::     <tt>integer</tt>
# *name*::       <tt>string</tt>
# *price*::      <tt>decimal(, )</tt>
# *promotion*::  <tt>boolean</tt>
# *status*::     <tt>integer</tt>
# *type_plan*::  <tt>integer</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
# *plan_id*::    <tt>bigint, indexed</tt>
# *user_id*::    <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_purchased_plans_on_plan_id  (plan_id)
#  index_purchased_plans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class PurchasedPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  enum status: { pending: 0, paid: 1, vanquished: 2, canceled: 3  }

  validates :name, presence: true
  validates :price, presence: true
  validates :type_plan, presence: true
  validates :mounts, presence: true
  validates :due_date, presence: true
end
