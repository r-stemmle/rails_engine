require 'rails_helper'

describe "GET /api/v1/merchants/find?name=iLl" do
  let(:valid_merchants) { FactoryBot.create_list(:random_merchant, 100) }
  let(:valid_headers) { Hash["Content-Type", "application/json"] }

  it "happy path, fetch one merchant by fragment" do
    valid_merchants
    get '/api/v1/merchants/find?name=iLl', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Hash
    expect(body[:data].keys.size).to eq(3)
    expect(body[:data][:attributes].size).to eq(1)
  end

  it "sad path, GET /api/v1/merchants/find?name=NOMATCH" do
    get '/api/v1/merchants/find?name=NOMATCH', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    expect(body[:data][:error]).to eq('no match')
  end
end
