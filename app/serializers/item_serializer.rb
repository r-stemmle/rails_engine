class ItemSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :unit_price
  # set_type :item
  # set_id :item_id
  belongs_to :merchant
  has_many :invoice_items
end
