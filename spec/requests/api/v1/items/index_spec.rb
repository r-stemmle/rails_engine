require 'rails_helper'


RSpec.describe "/items", type: :request do
  let(:valid_attributes) {
    {
      name: "Shiny",
      description: "It does a lot of things real good.",
      unit_price: 123.45,
      merchant_id: Merchant.last.id
    }
  }

  let(:new_attributes) {
    {
      name: "New",
      description: "Newness",
      unit_price: 50.45,
      merchant_id:  Merchant.last.id
    }

  }
  let(:invalid_attributes) {
    {
      name: "",
      description: "It does a lot of things real good.",
      unit_price: "123.45",
      merchant_id: 43
    }

  }
  let(:valid_items) {FactoryBot.create_list(:random_item, 100)}
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

  describe "GET /index" do
    it "renders a successful response" do
      valid_items
      get api_v1_items_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /api/v1/items?page=1" do
    it "happy path, fetching page 1 is the same list of first 20 in db" do
      valid_items
      get '/api/v1/items?page=1', as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(20)
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
  end

  describe "GET /api/v1/items?page=0" do
    it "sad path, fetching page 1 if page is 0 or lower" do
      valid_items
      get '/api/v1/items?page=1', as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(20)
    end
  end

  describe "GET /api/v1/items?page=2" do
    it "happy path, fetch second page of 20 items" do
      valid_items
      get '/api/v1/items?page=2', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(20)
    end
  end

  describe "GET /api/v1/items?per_page=50" do
    it "happy path, fetch first page of 50 items" do
      valid_items
      get '/api/v1/items?per_page=50', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(50)
    end
  end

  describe "GET /api/v1/items?page=200" do
    it "happy path, fetch a page of items which would contain no data" do
      valid_items
      get '/api/v1/items?page=200', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(0)
    end
  end

  describe "GET /api/v1/items?per_page=200" do
    it "happy path, fetch all items if per page is really big" do
      valid_items
      get '/api/v1/items?per_page=200', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(100)
    end
  end

  describe "GET /api/v1/items/{{item_id}}" do
    it "happy path, fetch one item by id" do
      item = valid_items.first
      get "/api/v1/items/#{item.id}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].keys).to eq(["id", "type", "attributes"])
      expect(JSON.parse(response.body)["data"]["id"]).to eq("#{item.id}")
      expect(JSON.parse(response.body)["data"]["type"]).to eq("item")
      expect(JSON.parse(response.body)["data"]["attributes"]).to be_a Hash
      expect(JSON.parse(response.body)["data"]["attributes"].size).to eq(4)
    end

    it "sad path, bad integer id or string returns 404" do
      valid_items
      expect { get '/api/v1/items/8923987297' }.to raise_exception(ActiveRecord::RecordNotFound)
      expect { get '/api/v1/items/string-instead-of-integer' }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST /api/v1/items" do
    it "response should be okay to process and create new item" do
      valid_items
      expect(Item.count).to eq(100)
      post '/api/v1/items', params: { item: valid_attributes }, headers: valid_headers, as: :json
      expect(Item.count).to eq(101)
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].keys).to eq(["id", "type", "attributes"])
      expect(JSON.parse(response.body)["data"]["id"]).to be_a String
      expect(JSON.parse(response.body)["data"]["type"]).to eq("item")
      expect(JSON.parse(response.body)["data"]["attributes"]).to be_a Hash
      expect(JSON.parse(response.body)["data"]["attributes"].size).to eq(4)
    end

    it "sad path with invalid parameters" do
      valid_items
      expect(Item.count).to eq(100)
      post '/api/v1/items', params: { item: invalid_attributes }, headers: valid_headers, as: :json
      expect(Item.count).to eq(100)
      expect(JSON.parse(response.body)).to be_a Hash
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

    it "sad path with bad attributes it returns 404" do
      item = valid_items.last
      expect { put "/api/v1/items/#{item.id}",
               params: { item: invalid_attributes },
               headers: valid_headers, as: :json }.to raise_exception(ActionController::RoutingError)
    end
  end
end
