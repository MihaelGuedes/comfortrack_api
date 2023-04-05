# == Schema Information
#
# Table name: permissions
#
# *id*::         <tt>bigint, not null, primary key</tt>
# *resource*::   <tt>string, not null, indexed</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#
# Indexes
#
#  index_permissions_on_resource  (resource)
#--
# == Schema Information End
#++
class Permission < ApplicationRecord
  has_many :group_policy_permissions, class_name: 'GroupPolicyPermission', dependent: :destroy
  has_many :group_policies, through: :group_policy_permissions

  scope :by_user_type, ->(group_type) {
    joins(:group_policies)
      .where(group_policies: { user_type: group_type })
  }

  # @return [String]
  def translate_resource
    I18n.t("permissions.#{resource}")
  end
end
