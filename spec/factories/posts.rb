FactoryBot.define do
  factory :post do
    title { 'サンプル投稿' }
    body { 'これはサンプル投稿の本文です。' }
    category { 'デフォルトカテゴリー' }
    genre { 'デフォルトジャンル' }
    public { true }
    association :user
  end
end
