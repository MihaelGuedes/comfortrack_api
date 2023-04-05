# == Schema Information
#
# Table name: group_policies
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *name*::       <tt>string</tt>
# *user_type*::  <tt>integer, indexed</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#
# Indexes
#
#  index_group_policies_on_user_type  (user_type)
#--
# == Schema Information End
#++
require 'rails_helper'

RSpec.describe GroupPolicy, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
