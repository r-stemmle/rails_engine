class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true, uniqueness: true

  def self.revenue_of_the_top(number= 1)
    self.joins(invoices: [:invoice_items, :transactions])
        .where(transactions: { result: 'success' } )
        .where(invoices: { status: 'shipped' } )
        .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
        .group('merchants.id')
        .order('revenue desc')
        .limit(number)
  end

  def self.revenue(merchant)
    self.joins(invoices: [:invoice_items, :transactions])
        .where(transactions: { result: 'success' } )
        .where(invoices: { status: 'shipped' } )
        .where(merchants: { id: merchant.id } )
        .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
        .group('merchants.id')
        .first
        .total_revenue
  end
end
