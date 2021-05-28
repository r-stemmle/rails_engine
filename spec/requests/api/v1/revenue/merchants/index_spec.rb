require 'rails_helper'

describe "GET /api/v1/revenue/merchants?quantity=10" do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }
  before :each do
    @m1 = create(:random_merchant)
    @m2 = create(:random_merchant)
    @m3 = create(:random_merchant)
    @m4 = create(:random_merchant)
    @m5 = create(:random_merchant)
    @m6 = create(:random_merchant)
    @item = create(:random_item, merchant: @m1)
    @invoice = create(:random_invoice, merchant: @m1)
    @ii = create(:random_invoice_item, invoice: @invoice, item: @item)
    @transaction = create(:random_transaction, invoice: @invoice)
  end

  it "happy path, fetch top 1 merchants by revenue" do
    get '/api/v1/revenue/merchants?quantity=10', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array
    expect(body[:data].size).to eq(1)
    expect(body[:data].first).to be_a Hash
    expect(body[:data].first[:attributes]).to be_a Hash
    expect(body[:data].first[:attributes][:name]).to be_a String
    expect(body[:data].first[:attributes][:revenue]).to be_a Float
    expect(body[:data].first.keys).to eq([:id, :type, :attributes])

    get '/api/v1/revenue/merchants?quantity=100', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array
    expect(body[:data].size).to eq(1)

    get '/api/v1/revenue/merchants?quantity=', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(response.status).to eq(400)
    expect(body[:error]).to eq("missing params")
  end
end
