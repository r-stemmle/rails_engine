require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many :customers }
    it { should have_many :invoice_items }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe "class methods" do
    it "returns the merchant(s) with the most revenue" do
      @m1 = create(:random_merchant)
      @m2 = create(:random_merchant)
      @item = create(:random_item, merchant: @m1)
      @item2 = create(:random_item, merchant: @m2)
      @invoice = create(:random_invoice, merchant: @m1)
      @invoice2 = create(:random_invoice, merchant: @m2)
      @ii = create(:random_invoice_item, invoice: @invoice, item: @item)
      @ii2 = create(:random_invoice_item, invoice: @invoice2, item: @item2, quantity: 1, unit_price: 1)
      @transaction = create(:random_transaction, invoice: @invoice)
      @transaction2 = create(:random_transaction, invoice: @invoice2)

      expect(Merchant.revenue_of_the_top.first.name).to eq(@m1.name)
    end

    it "returns revenue for a single merchant" do
      merchant = create(:random_merchant)
      item = create(:random_item, merchant: merchant)
      invoice = create(:random_invoice, merchant: merchant)
      invoice_item = create(:random_invoice_item, invoice: invoice, item: item)
      transaction = create(:random_transaction, invoice: invoice)

      expect(Merchant.revenue(merchant)).to eq(invoice_item.unit_price * invoice_item.quantity)
    end
  end
end
