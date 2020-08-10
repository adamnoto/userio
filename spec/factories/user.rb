FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.org" }
    sequence(:username) { |n| "user#{n}" }
    password { "Password01" }
  end
end
