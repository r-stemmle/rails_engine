class ItemSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :unit_price, :merchant_id 
  # set_type :item
  # set_id :item_id
  belongs_to :merchant
  has_many :invoice_items
end
