require 'rails_helper'

describe "GET /api/v1/items/find_all?name=hArU" do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }
  let(:valid_items) {FactoryBot.create_list(:random_item, 100)}

  it "happy path, fetch all items matching a pattern" do
    valid_items
    get '/api/v1/items/find_all?name=nD', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array
    expect(body[:data].first).to be_a Hash
    expect(body[:data].first[:id]).to be_a String
    expect(body[:data].first[:type]).to be_a String
    expect(body[:data].first[:attributes]).to be_a Hash
    expect(body[:data].first[:attributes].keys.size).to eq(4)
    expect(body[:data].first[:attributes][:name]).to be_a String
    expect(body[:data].first[:attributes][:description]).to be_a String
    expect(body[:data].first[:attributes][:unit_price]).to be_a Float
    expect(body[:data].first[:attributes][:merchant_id]).to be_a Integer
  end

  it "sad path, GET /api/v1/merchants/find?name=NOMATCH" do
    get '/api/v1/items/find_all?name=NOMATCH', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    expect(body[:data]).to be_a Array
    expect(body[:data]).to eq([])
  end
end
