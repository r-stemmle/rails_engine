class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates :name, :description, presence: true
  validates :unit_price, :merchant_id, numericality: true, presence: true
end
