require "rails_helper"

RSpec.describe Api::V1::RevenueController, type: :routing do
  describe "routing" do
    it "routes to #weekly" do
      expect(get: "/api/v1/revenue/weekly").to route_to("api/v1/revenue#weekly")
    end

    it "routes to #items" do
      expect(get: "/api/v1/revenue/items").to route_to("api/v1/revenue#items")
    end

    it "routes to #merchants" do
      expect(get: "/api/v1/revenue/merchants").to route_to("api/v1/revenue#merchants")
    end

    it "routes to #merchant" do
      expect(get: "/api/v1/revenue/merchants/1").to route_to("api/v1/revenue#merchant", id: "1")
    end
  end
end
