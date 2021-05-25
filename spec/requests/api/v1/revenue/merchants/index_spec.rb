require 'rails_helper'

describe "GET /api/v1/revenue/merchants?quantity=10" do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }
  let(:valid_merchants) {FactoryBot.create_list(:random_merchant, 20)}
  let(:valid_items) {FactoryBot.create_list(:random_item, 250)}
  let(:valid_invoice_items) {FactoryBot.create_list(:random_invoice_item, 1000)}
  let(:valid_invoices) {FactoryBot.create_list(:random_invoice, 400)}
  let(:valid_transactions) {FactoryBot.create_list(:random_transaction, 400)}

  it "happy path, fetch top 10 merchants by revenue" do
    valid_merchants
    valid_items
    valid_invoices
    valid_invoice_items
    valid_transactions
    get '/api/v1/revenue/merchants?quantity=10', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array
    expect(body[:data].first).to be_a Hash
    expect(body[:data].first[:attributes]).to be_a Hash
    expect(body[:data].first[:attributes][:name]).to be_a String
    expect(body[:data].first[:attributes][:revenue]).to be_a Float
    expect(body[:data].first.keys).to eq([:id, :type, :attributes])

    get '/api/v1/revenue/merchants?quantity=100', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array

    get '/api/v1/revenue/merchants?quantity=', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to be_a Hash
    expect(response.status).to eq(400)
    expect(body[:error]).to eq("missing params")
  end


end
