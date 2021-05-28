require 'rails_helper'

RSpec.describe 'Items show page', type: :request do
  let(:valid_items) { FactoryBot.create_list(:random_item, 10) }
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

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
end
