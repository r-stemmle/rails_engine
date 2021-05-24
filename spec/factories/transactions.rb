FactoryBot.define do
  factory :random_transaction, class: Transaction do
    credit_card_number { Faker::Business.credit_card_number.gsub('-', '') }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { rand(0..1)}

    association :invoice, factory: :random_invoice
  end
end
