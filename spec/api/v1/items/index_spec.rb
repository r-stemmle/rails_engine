require 'rails_helper'

describe "Items index response" do
  context "As a user sending a get request for items with no parameters" do
    it "I exepect to see a json response with a page of 20 items" do
      user_request = get '/api/v1/items'

      expect(user_request).to have_status

    end
  end
end
