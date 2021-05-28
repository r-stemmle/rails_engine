require 'rails_helper'

RSpec.describe Api::V1::Items::MerchantController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/api/v1/items/1/merchant").to route_to("api/v1/items/merchant#show", item_id: "1")
    end
  end
end
