class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :invoice_id, presence: true
  validates :item_id, presence: true
  validates :unit_price, presence: true
  validates :quantity, presence: true
end
