require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
  end
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
    it { should validate_numericality_of :unit_price }
    it { should validate_numericality_of :merchant_id }
  end

  describe "class methods" do
    it "should return the revenue for given amount of items" do
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

      expect(Item.revenue_of_the_top.first.name).to eq(@item.name)
      expect(Item.revenue_of_the_top.first.revenue).to be_a Float
      expect(Item.revenue_of_the_top.first.revenue).to eq(@ii.unit_price * @ii.quantity)
    end
  end
end
