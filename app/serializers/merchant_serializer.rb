class MerchantSerializer
  include JSONAPI::Serializer

  attributes :name
  # set_type :merchant
  # set_id :merchant_id
  has_many :items
  has_many :invoices
end
