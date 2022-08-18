FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.first_name }
    password { 'password' }
    password_confirmation { 'password' }
  end
end