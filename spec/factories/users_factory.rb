FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password 'password1'
  end
end
