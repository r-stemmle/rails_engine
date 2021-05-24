require 'rails_helper'

RSpec.describe "/merchants", type: :request do
  let(:valid_merchants) { FactoryBot.create_list(:random_merchant, 100) }
  let(:invalid_merchants) { FactoryBot.create_list(:random_item, 20) }
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

  describe "GET /index" do
    it "renders a successful response" do
      valid_merchants
      get api_v1_merchants_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      merchant = valid_merchants.first
      get api_v1_merchant_url(merchant), as: :json
      expect(response).to be_successful
    end
  end

  describe "/api/v1/merchants?per_page=200" do
    it "happy path, fetch all merchants if per page is really big" do
      valid_merchants
      get '/api/v1/merchants?per_page=200', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(100)
    end
  end

  describe "/api/v1/merchants?page=200" do
    it "happy path, fetch a page of merchants which would contain no data" do
      valid_merchants
      get '/api/v1/merchants?page=200', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(0)
    end
  end

  describe "/api/v1/merchants?per_page=50" do
    it "happy path, fetch first page of 50 merchants" do
      valid_merchants
      get '/api/v1/merchants?per_page=50', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(50)
    end
  end

  describe "/api/v1/merchants?page=2" do
    it "happy path, fetch second page of 20 merchants" do
      valid_merchants
      get '/api/v1/merchants?page=2', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(20)
    end
  end

  describe "/api/v1/merchants?page=0" do
    it "sad path, fetching page 1 if page is 0 or lower" do
      valid_merchants
      get '/api/v1/merchants?page=0', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(20)
    end
  end

  describe "/api/v1/merchants?page=1" do
    it "happy path, fetching page 1 is the same list of first 20 in db" do
      valid_merchants
      get '/api/v1/merchants?page=1', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].size).to eq(20)
    end
  end

  describe "/api/v1/merchants/{{merchant_id}}" do
    it "happy path, fetch one merchant by id" do
      merchant = valid_merchants.first
      get "/api/v1/merchants/#{merchant.id}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"].keys).to eq(["id", "type", "attributes"])
      expect(JSON.parse(response.body)["data"]["id"]).to eq("#{merchant.id}")
      expect(JSON.parse(response.body)["data"]["type"]).to eq("merchant")
      expect(JSON.parse(response.body)["data"]["attributes"]).to be_a Hash 
    end

    it "sad path, bad integer id returns 404" do
      valid_merchants
      expect { get '/api/v1/merchants/8923987297' }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
