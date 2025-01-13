FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { Faker::Internet.email }
    password { 'password' }
    guest { false }

    trait :guest do
      guest { true }
    end
  end
end
