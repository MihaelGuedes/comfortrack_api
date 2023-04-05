# == Schema Information
#
# Table name: group_policy_permissions
#
# *id*::              <tt>bigint, not null, primary key</tt>
# *created_at*::      <tt>datetime, not null</tt>
# *updated_at*::      <tt>datetime, not null</tt>
# *group_policy_id*:: <tt>bigint, not null, indexed</tt>
# *permission_id*::   <tt>bigint, not null, indexed</tt>
#
# Indexes
#
#  index_group_policy_permissions_on_group_policy_id  (group_policy_id)
#  index_group_policy_permissions_on_permission_id    (permission_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_policy_id => group_policies.id)
#  fk_rails_...  (permission_id => permissions.id)
#--
# == Schema Information End
#++
class GroupPolicyPermission < ApplicationRecord
  belongs_to :permission, optional: true
  belongs_to :group_policy, optional: true
end
