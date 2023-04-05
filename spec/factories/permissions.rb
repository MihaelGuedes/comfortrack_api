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
FactoryBot.define do
  factory :permission do
    resource { Faker::Name.name }
  end
end
