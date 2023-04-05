FactoryBot.define do
  factory :admin_user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    user_type { 'admin_user' }
  end
end
