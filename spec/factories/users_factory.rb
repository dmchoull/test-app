FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password 'password1'

    association :profile, strategy: :build

    factory :user_without_profile do
      profile nil
    end
  end
end
