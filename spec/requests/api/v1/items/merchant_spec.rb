require 'rails_helper'

describe "GET /api/v1/items/{{item_id}}/merchant", type: :request do
  let(:valid_headers) { Hash["Content-Type", "application/json"] }
  it "happy path, fetch one merchant by item id" do
    #we need item
    merchant = create(:random_merchant)
    item = create(:random_item, merchant: merchant)
    get "/api/v1/items/#{item.id}/merchant", headers: valid_headers, as: :json
    expect(response).to be_successful
  end

  it "sad path, return 404 with bad id or string for id" do
    expect { get "/api/v1/items/123456/merchant" }.to raise_exception(ActiveRecord::RecordNotFound)
    expect { get "/api/v1/items/'1'/merchant" }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
