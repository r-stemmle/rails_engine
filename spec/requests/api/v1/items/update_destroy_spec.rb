require 'rails_helper'

RSpec.describe "items update and destroy test", type: :request do
  let(:valid_items) { FactoryBot.create_list(:random_item, 10) }
  let(:valid_headers) { Hash["Content-Type", "application/json"] }
  let(:valid_attributes) do
    {
      name: "Shiny",
      description: "It does a lot of things real good.",
      unit_price: 123.45,
      merchant_id: Merchant.last.id
    }
  end
  let(:new_attributes) do
    {
      name: "New",
      description: "Newness",
      unit_price: 50.45,
      merchant_id:  Merchant.last.id
    }
  end
  let(:invalid_attributes) do
    {
      name: "",
      description: "It does a lot of things real good.",
      unit_price: "123.45",
      merchant_id: 43
    }
  end

  describe "POST /api/v1/items" do
    it "response should be okay to process and create new item" do
      valid_items
      expect(Item.count).to eq(10)
      post '/api/v1/items', params: { item: valid_attributes }, headers: valid_headers, as: :json
      expect(Item.count).to eq(11)
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].keys).to eq(["id", "type", "attributes"])
      expect(JSON.parse(response.body)["data"]["id"]).to be_a String
      expect(JSON.parse(response.body)["data"]["type"]).to eq("item")
      expect(JSON.parse(response.body)["data"]["attributes"]).to be_a Hash
      expect(JSON.parse(response.body)["data"]["attributes"].size).to eq(4)
    end

    it "sad path with invalid parameters" do
      valid_items
      expect(Item.count).to eq(10)
      post '/api/v1/items', params: { item: invalid_attributes }, headers: valid_headers, as: :json
      expect(Item.count).to eq(10)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a Hash
    end
  end

  describe "PUT /api/v1/items/item_id" do
    it "happy path it updates the item with valid attributes" do
      item = valid_items.last
      get "/api/v1/items/#{item.id}", headers: valid_headers, as: :json
      price_1 = JSON.parse(response.body)["data"]["attributes"]["unit_price"]
      put "/api/v1/items/#{item.id}", params: { item: new_attributes }, headers: valid_headers, as: :json
      expect(JSON.parse(response.body)).to be_a Hash
      price_2 = JSON.parse(response.body)["data"]["attributes"]["unit_price"]
      expect(price_1).to_not eq(price_2)
    end

    it "sad path with bad attributes it returns 422" do
      item = valid_items.last
      put "/api/v1/items/#{item.id}", params: { item: invalid_attributes }, headers: valid_headers, as: :json
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a Hash
      expect(body[:errors]).to eq("invalid attributes")
      expect(response.status).to eq(422)
    end

    it "sad path with no attributes it returns 422" do
      item = valid_items.last
      put "/api/v1/items/#{item.id}", headers: valid_headers, as: :json
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a Hash
      expect(body[:errors]).to eq("no attributes")
      expect(response.status).to eq(422)
    end

    it "destroys record with valid id" do
      item = valid_items.last
      expect(Item.count).to eq(10)
      delete "/api/v1/items/#{item.id}", headers: valid_headers, as: :json
      expect(Item.count).to eq(9)
      expect(response.status).to eq(204)
    end
  end
end
