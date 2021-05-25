FactoryBot.define do
  results = ['success', 'failed']

  factory :random_transaction, class: Transaction do
    credit_card_number { Faker::Business.credit_card_number.gsub('-', '') }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { results.shuffle.first }
    invoice_id { rand(1..400) }
    # association :invoice, factory: :random_invoice
  end
end
