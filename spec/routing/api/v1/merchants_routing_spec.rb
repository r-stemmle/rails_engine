require "rails_helper"

RSpec.describe Api::V1::MerchantsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/merchants").to route_to("api/v1/merchants#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/merchants/1").to route_to("api/v1/merchants#show", id: "1")
    end

    it "routes to #find" do
      expect(get: "/api/v1/merchants/find").to route_to("api/v1/merchants#find")
    end
  end
end
