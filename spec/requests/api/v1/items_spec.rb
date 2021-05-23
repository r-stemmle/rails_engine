require 'rails_helper'


RSpec.describe "/items", type: :request do
  let(:valid_items) {FactoryBot.create_list(:random_item, 100)}
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

  describe "GET /index" do
    it "renders a successful response" do
      valid_items
      get api_v1_items_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      item = valid_items.last
      get api_v1_item_url(item), as: :json
      expect(response).to be_successful
    end
  end

#   describe "POST /create" do
#     context "with valid parameters" do
#       it "creates a new Item" do
#         expect {
#           post api_v1_items_url,
#                params: { api/v1_item: valid_attributes }, headers: valid_headers, as: :json
#         }.to change(Item, :count).by(1)
#       end
#
#       it "renders a JSON response with the new api/v1_item" do
#         post api_v1_items_url,
#              params: { api/v1_item: valid_attributes }, headers: valid_headers, as: :json
#         expect(response).to have_http_status(:created)
#         expect(response.content_type).to match(a_string_including("application/json"))
#       end
#     end
#
#     context "with invalid parameters" do
#       it "does not create a new Item" do
#         expect {
#           post api_v1_items_url,
#                params: { api/v1_item: invalid_attributes }, as: :json
#         }.to change(Item, :count).by(0)
#       end
#
#       it "renders a JSON response with errors for the new api/v1_item" do
#         post api_v1_items_url,
#              params: { api/v1_item: invalid_attributes }, headers: valid_headers, as: :json
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.content_type).to eq("application/json")
#       end
#     end
#   end
#
#   describe "PATCH /update" do
#     context "with valid parameters" do
#       let(:new_attributes) {
#         skip("Add a hash of attributes valid for your model")
#       }
#
#       it "updates the requested api/v1_item" do
#         item = Item.create! valid_attributes
#         patch api_v1_item_url(item),
#               params: { item: new_attributes }, headers: valid_headers, as: :json
#         item.reload
#         skip("Add assertions for updated state")
#       end
#
#       it "renders a JSON response with the api/v1_item" do
#         item = Item.create! valid_attributes
#         patch api_v1_item_url(item),
#               params: { item: new_attributes }, headers: valid_headers, as: :json
#         expect(response).to have_http_status(:ok)
#         expect(response.content_type).to match(a_string_including("application/json"))
#       end
#     end
#
#     context "with invalid parameters" do
#       it "renders a JSON response with errors for the api/v1_item" do
#         item = Item.create! valid_attributes
#         patch api_v1_item_url(item),
#               params: { item: invalid_attributes }, headers: valid_headers, as: :json
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.content_type).to eq("application/json")
#       end
#     end
#   end
#
#   describe "DELETE /destroy" do
#     it "destroys the requested api/v1_item" do
#       item = Item.create! valid_attributes
#       expect {
#         delete api_v1_item_url(item), headers: valid_headers, as: :json
#       }.to change(Item, :count).by(-1)
#     end
#   end
end
