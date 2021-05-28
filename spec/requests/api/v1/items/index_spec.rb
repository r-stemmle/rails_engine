require 'rails_helper'


RSpec.describe "/items", type: :request do
  let(:valid_items) { FactoryBot.create_list(:random_item, 100) }
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
end
