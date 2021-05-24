class CustomerSerializer
  include JSONAPI::Serializer

  # set_type :customer
  # set_id :customer_id
  attributes :first_name, :last_name
  has_many :invoices
end
