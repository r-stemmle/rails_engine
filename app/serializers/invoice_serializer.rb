class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :customer_id, :merchant_id, :status

  has_many :transactions
  has_many :invoice_items
end
