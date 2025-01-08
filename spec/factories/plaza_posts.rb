FactoryBot.define do
  factory :plaza_post do
    title { 'テスト投稿タイトル' }
    content { 'テスト投稿内容' }
    association :user
  end
end
