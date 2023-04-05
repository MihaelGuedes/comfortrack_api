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
FactoryBot.define do
  factory :group_policy do
    name { Faker::Name.name }
    user_type { :admin_user }


    trait :admin do
      user_type { :admin_user }
    end

    trait :with_permissions do
      transient do
        permissions_count { 3 }
      end

      after(:create) do |group_policy, evaluator|
        create_list(:permission, evaluator.permissions_count, group_policies: [group_policy])
      end
    end
  end
end
