require 'rails_helper'

describe "GET /api/v1/items/{{item_id}}/merchant", type: :request do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

  it "happy path, fetch one merchant by item id" do
    merchant = create(:random_merchant)
    item = create(:random_item, merchant: merchant)
    get "/api/v1/items/#{item.id}/merchant", headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Hash
    expect(body[:data].size).to eq(3)
    expect(body[:data][:id]).to be_a String
    expect(body[:data][:type]).to be_a String
    expect(body[:data][:attributes]).to be_a Hash
    expect(body[:data][:attributes].size).to eq(1)
    expect(body[:data][:attributes][:name]).to be_a String
  end

  it "sad path, return 404 with bad id or string for id" do
    get "/api/v1/items/123456/merchant", headers: valid_headers, as: :json
    expect(response.status).to eq(404)
    get "/api/v1/items/'1'/merchant", headers: valid_headers, as: :json
    expect(response.status).to eq(404)
  end
end
