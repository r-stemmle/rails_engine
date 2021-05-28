require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/merchants/1/items").to route_to("api/v1/merchants/items#index", merchant_id: "1")
    end
  end
end
