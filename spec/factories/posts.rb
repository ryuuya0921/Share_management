FactoryBot.define do
  factory :post do
    title { "Sample Post" }
    body { "This is a sample post body." }
    category { "Default Category" } # 必要なら適宜変更
    genre { "Default Genre" } # 必要なら適宜変更
    public { true } # 公開状態
    association :user # ユーザーとの関連付け
  end
end
