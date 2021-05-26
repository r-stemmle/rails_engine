require 'rails_helper'

describe "GET /api/v1/revenue/merchants/{{merchant_id}}" do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }
  before :each do
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
  end

  it "happy path, fetch revenue for merchant id" do
    get "/api/v1/revenue/merchants/#{@m1.id}", headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Hash
    expect(body[:data].size).to eq(3)
    expect(body[:data][:id]).to be_a String
    expect(body[:data][:attributes]).to be_a Hash
    expect(body[:data][:attributes].size).to eq(1)
    expect(body[:data][:attributes][:revenue]).to be_a Float
  end

  it "sad path, bad integer id returns 404" do
    expect {get '/api/v1/revenue/merchants/235674322' }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
