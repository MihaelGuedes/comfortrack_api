# == Schema Information
#
# Table name: purchased_plans
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *name*::       <tt>string</tt>
# *price*::      <tt>decimal(, )</tt>
# *promotion*::  <tt>boolean</tt>
# *type_plan*::  <tt>integer</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
# *user_id*::    <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_purchased_plans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class PurchasedPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :name, presence: true
  validates :price, presence: true
  validates :type_plan, presence: true
end
