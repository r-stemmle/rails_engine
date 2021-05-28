require 'rails_helper'

describe "/api/v1/revenue/weekly" do
  it "happy path, fetch monthly revenue" do
    valid_headers = Hash["Content-Type", "application/json"]
    invoice_1 = create(:random_invoice, created_at: '2012-03-05 00:00:00')
    invoice_2 = create(:random_invoice, created_at: '2012-03-12 00:00:00')
    invoice_3 = create(:random_invoice, created_at: '2012-03-19 00:00:00')
    invoice_4 = create(:random_invoice, created_at: '2012-03-26 00:00:00')
    invoice_5 = create(:random_invoice, created_at: '2012-03-05 00:00:00')
    transaction_1 = create(:random_transaction, invoice: invoice_1 )
    transaction_2 = create(:random_transaction, invoice: invoice_2 )
    transaction_3 = create(:random_transaction, invoice: invoice_3 )
    transaction_4 = create(:random_transaction, invoice: invoice_4 )
    transaction_5 = create(:random_transaction, invoice: invoice_5 )
    item_1 = create(:random_item)
    item_2 = create(:random_item)
    item_3 = create(:random_item)
    item_4 = create(:random_item)
    item_5 = create(:random_item)
    ii_1 = create(:random_invoice_item, item: item_1, invoice: invoice_1)
    ii_2 = create(:random_invoice_item, item: item_2, invoice: invoice_2)
    ii_3 = create(:random_invoice_item, item: item_3, invoice: invoice_3)
    ii_4 = create(:random_invoice_item, item: item_4, invoice: invoice_4)
    ii_5 = create(:random_invoice_item, item: item_5, invoice: invoice_5)

    get '/api/v1/revenue/weekly', headers: valid_headers, as: :json
    body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(body).to be_a Hash
    expect(body[:data]).to be_a Array
    expect(body[:data].size).to eq(4)
    expect(body[:data].first).to be_a Hash
    expect(body[:data].first[:attributes][:week]).to be_a String
    expect(body[:data].first[:attributes][:revenue]).to be_a Float
  end
end
