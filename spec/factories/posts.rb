FactoryBot.define do
  factory :post do
    title { 'Sample Post' }
    body { 'This is a sample post body.' }
    category { 'Default Category' }
    genre { 'Default Genre' }
    public { true }
    association :user
  end
end
