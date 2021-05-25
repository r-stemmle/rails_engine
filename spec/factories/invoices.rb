FactoryBot.define do
  invoice_status = ['packaged', 'shipped']
  factory :random_invoice, class: Invoice do
    status { invoice_status.shuffle.first }
    merchant_id { rand(1..20) }

    association :customer, factory: :random_customer
    # association :merchant, factory: :random_merchant
  end
end
