# == Schema Information
#
# Table name: orders
#
# *id*::            <tt>uuid, not null, primary key</tt>
# *status*::        <tt>integer</tt>
# *tracking_code*:: <tt>string</tt>
# *created_at*::    <tt>datetime, not null</tt>
# *updated_at*::    <tt>datetime, not null</tt>
# *product_id*::    <tt>bigint, not null, indexed</tt>
# *user_id*::       <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_orders_on_product_id  (product_id)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  enum status: { pending: 0, paid: 1, vanquished: 2, canceled: 3  }, _default: 0
  
  validates :tracking_code, presence: true  
end
