# == Schema Information
#
# Table name: user_permissions
#
# *id*::            <tt>uuid, not null, primary key</tt>
# *created_at*::    <tt>datetime, not null</tt>
# *updated_at*::    <tt>datetime, not null</tt>
# *permission_id*:: <tt>bigint, not null, indexed</tt>
# *user_id*::       <tt>uuid, not null, indexed</tt>
#
# Indexes
#
#  index_user_permissions_on_permission_id  (permission_id)
#  index_user_permissions_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (permission_id => permissions.id)
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
require 'rails_helper'

RSpec.describe UserPermission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
