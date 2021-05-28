class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates :name, :description, presence: true
  validates :unit_price, :merchant_id, numericality: true, presence: true

  def self.revenue_of_the_top(number= 10)
    self.joins(invoice_items: {invoice: :transactions})
        .where(transactions: { result: 'success' } )
        .where(invoices: { status: 'shipped' } )
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
        .group('items.id')
        .order('revenue desc')
        .limit(number.to_i)
  end

end
