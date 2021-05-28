class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :transactions

  belongs_to :customer
  belongs_to :merchant

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true

  def self.weekly_revenue
    self.joins([:invoice_items, :transactions])
        .where(transactions: { result: 'success' } )
        .where(invoices: { status: 'shipped' } )
        .select("DATE_TRUNC('week', invoices.created_at) as week, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
        .group('week')
        .order('week')
  end
end
