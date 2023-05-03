
class Product < ApplicationRecord
  enum product_type: { collar: 0, battery: 1, clasp: 2 }

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :product_type, presence: true
end
