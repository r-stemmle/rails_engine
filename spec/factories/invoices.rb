FactoryBot.define do
  factory :random_invoice, class: Invoice do
    status { rand(0..2) }
    association :customer, factory: :random_customer
    association :merchant, factory: :random_merchant
  end
end
