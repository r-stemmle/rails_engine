require 'rails_helper'

RSpec.describe "/merchants", type: :request do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

  describe "GET /api/v1/merchants/{{merchant_id}}/items" do
    it "happy path, fetch all items" do
      merchant = create(:random_merchant)
      10.times { create(:random_item, merchant: merchant) }
      get "/api/v1/merchants/#{merchant.id}/items", headers: valid_headers, as: :json
      expect(JSON.parse(response.body)["data"].size).to eq(10)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a Hash
      expect(body[:data]).to be_a Array
      expect(body[:data].first).to be_a Hash
      expect(body[:data].first[:id]).to be_a String
      expect(body[:data].first[:type]).to be_a String
      expect(body[:data].first[:attributes]).to be_a Hash
      expect(body[:data].first[:attributes][:name]).to be_a String
      expect(body[:data].first[:attributes][:description]).to be_a String
      expect(body[:data].first[:attributes][:unit_price]).to be_a Float
      expect(body[:data].first[:attributes][:merchant_id]).to be_a Integer
    end

    it "sad path, bad integer id returns 404" do
      expect { get '/api/v1/merchants/8923987297/items' }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
