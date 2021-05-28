FactoryBot.define do
  factory :random_item, class: Item do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence(word_count: 3) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    
    association :merchant, factory: :random_merchant
  end
end
