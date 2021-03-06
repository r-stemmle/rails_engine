FactoryBot.define do
  factory :random_invoice_item, class: InvoiceItem do
    quantity { rand(0..10) }
    unit_price { Faker::Number.decimal(l_digits: 2) }

    association :invoice, factory: :random_invoice
    association :item, factory: :random_item
  end
end
