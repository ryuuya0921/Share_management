FactoryBot.define do
  factory :comment do
    content { 'テストコメント' }
    association :plaza_post
    association :user
  end
end
