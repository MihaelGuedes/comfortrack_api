# == Schema Information
#
# Table name: users
#
# *id*::                    <tt>bigint, not null, primary key</tt>
# *avatar*::                <tt>string</tt>
# *email*::                 <tt>string(200), not null, indexed</tt>
# *first_name*::            <tt>string(100), not null</tt>
# *last_name*::             <tt>string(100), not null</tt>
# *password_digest*::       <tt>string, not null</tt>
# *password_reset_token*::  <tt>string</tt>
# *password_token_expiry*:: <tt>datetime</tt>
# *phone*::                 <tt>string</tt>
# *status*::                <tt>integer, default("active"), not null</tt>
# *user_type*::             <tt>string(100), not null</tt>
# *created_at*::            <tt>datetime, not null</tt>
# *updated_at*::            <tt>datetime, not null</tt>
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#--
# == Schema Information End
#++
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |_n| Faker::Internet.email }
    password { '123456' }
    phone { Faker::PhoneNumber.cell_phone }

    trait :admin do
      user_type { 'admin' }
    end

    trait :api do
      user_type { 'api' }
    end

    trait :tutor do
      user_type { 'tutor' }
    end

    trait :suporte do
      user_type { 'suporte' }
    end

    trait :with_permissions do
      transient do
        permissions_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:user_permission, evaluator.permissions_count, user:)
      end
    end

  end
end
