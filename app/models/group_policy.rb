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
class GroupPolicy < ApplicationRecord
  enum user_type: { admin: 0, tutor: 1, suporte: 2 }
  has_many :group_policy_permissions, class_name: 'GroupPolicyPermission', dependent: :destroy
  has_many :permissions, through: :group_policy_permissions
end
