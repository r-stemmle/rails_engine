require 'rails_helper'

describe "GET /api/v1/revenue/items" do
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

  it "happy path, fetch top 2 items by revenue" do
    get '/api/v1/revenue/items', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array
    expect(body[:data].size).to eq(2)
    expect(body[:data].first).to be_a Hash
    expect(body[:data].first[:id]).to be_a String
    expect(body[:data].first[:type]).to be_a String
    expect(body[:data].first[:attributes]).to be_a Hash
    expect(body[:data].first[:attributes][:name]).to be_a String
    expect(body[:data].first[:attributes][:description]).to be_a String
    expect(body[:data].first[:attributes][:unit_price]).to be_a Float
    expect(body[:data].first[:attributes][:merchant_id]).to be_a Integer
    expect(body[:data].first[:attributes][:revenue]).to be_a Float
  end

  it "happy path, top one item by revenue" do
    get '/api/v1/revenue/items?quantity=1', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(body[:data].size).to eq(1)
  end

  it "happy path, return all items if quantity is too big" do
    get '/api/v1/revenue/items?quantity=100', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data].size).to eq(2)
    expect(response).to be_successful
  end

  it "sad path, returns an error of some sort if quantity value is less than 0" do
    get '/api/v1/revenue/items?quantity=-1', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to_not be_successful
  end

  it "edge case sad path, returns an error of some sort if quantity value is blank" do
    get '/api/v1/revenue/items?quantity=', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to_not be_successful
  end

  it "edge case sad path, returns an error of some sort if quantity is a string" do
    get "/api/v1/revenue/items?quantity='1'", headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to_not be_successful
  end

end
