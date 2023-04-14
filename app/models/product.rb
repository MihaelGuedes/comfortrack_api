# == Schema Information
#
# Table name: products
#
# *id*::           <tt>bigint, not null, primary key</tt>
# *description*::  <tt>text</tt>
# *name*::         <tt>string</tt>
# *price*::        <tt>decimal(, )</tt>
# *product_type*:: <tt>integer</tt>
# *created_at*::   <tt>datetime, not null</tt>
# *updated_at*::   <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
class Product < ApplicationRecord
  enum product_type: { collar: 0, battery: 1, clasp: 2 }

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :product_type, presence: true
end
