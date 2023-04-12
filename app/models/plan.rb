# == Schema Information
#
# Table name: plans
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *name*::       <tt>string</tt>
# *price*::      <tt>decimal(, )</tt>
# *type_plan*::  <tt>integer</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
class Plan < ApplicationRecord

  enum type_plan: { basic: 0, gold: 1, platinum: 2, diamond: 3 }

  validates :name, presence: true
  validates :price, presence: true
  validates :type_plan, presence: true
end
