FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name { Faker::Company.name }
  end
end
