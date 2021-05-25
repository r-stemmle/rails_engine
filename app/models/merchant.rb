class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.revenue_of_the_top(number)
    self.joins(invoices: [:invoice_items, :transactions])
        .where(transactions: { result: 'success' } )
        .where(invoices: { status: 'shipped' } )
        .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
        .group('merchants.id')
        .order('revenue desc')
        .limit(number)
  end
end
