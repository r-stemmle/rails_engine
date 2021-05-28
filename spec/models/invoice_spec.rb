require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
  end


  describe "class methods" do
    it "happy path, fetch monthly revenue" do
      valid_headers = Hash["Content-Type", "application/json"]
      invoice_1 = create(:random_invoice, created_at: '2012-03-05 00:00:00')
      invoice_2 = create(:random_invoice, created_at: '2012-03-12 00:00:00')
      invoice_3 = create(:random_invoice, created_at: '2012-03-19 00:00:00')
      invoice_4 = create(:random_invoice, created_at: '2012-03-26 00:00:00')
      invoice_5 = create(:random_invoice, created_at: '2012-03-05 00:00:00')
      transaction_1 = create(:random_transaction, invoice: invoice_1 )
      transaction_2 = create(:random_transaction, invoice: invoice_2 )
      transaction_3 = create(:random_transaction, invoice: invoice_3 )
      transaction_4 = create(:random_transaction, invoice: invoice_4 )
      transaction_5 = create(:random_transaction, invoice: invoice_5 )
      item_1 = create(:random_item)
      item_2 = create(:random_item)
      item_3 = create(:random_item)
      item_4 = create(:random_item)
      item_5 = create(:random_item)
      ii_1 = create(:random_invoice_item, item: item_1, invoice: invoice_1)
      ii_2 = create(:random_invoice_item, item: item_2, invoice: invoice_2)
      ii_3 = create(:random_invoice_item, item: item_3, invoice: invoice_3)
      ii_4 = create(:random_invoice_item, item: item_4, invoice: invoice_4)
      ii_5 = create(:random_invoice_item, item: item_5, invoice: invoice_5)

      expect(Invoice.weekly_revenue.first.week).to be_a Time
      expect(Invoice.weekly_revenue.first.revenue).to be_a Float
    end
  end
end
