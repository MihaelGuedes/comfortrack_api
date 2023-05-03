# == Schema Information
#
# Table name: purchased_products
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *name*::       <tt>string</tt>
# *price*::      <tt>string</tt>
# *promotion*::  <tt>boolean</tt>
# *status*::     <tt>integer</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
# *product_id*:: <tt>bigint, not null, indexed</tt>
# *user_id*::    <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_purchased_products_on_product_id  (product_id)
#  index_purchased_products_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class PurchasedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :user

  enum status: { pending: 0, paid: 1, vanquished: 2, canceled: 3  }, _default: 0
  enum product_type: { collar: 0, battery: 1, clasp: 2 }

  validates :name, presence: true
  validates :price, presence: true
  validates :promotion, presence: true
end
