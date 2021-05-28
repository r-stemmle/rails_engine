class Api::V1::RevenueController < ApplicationController
  before_action :set_merchant, only: :merchant

  def merchants
    if params[:quantity].to_i < 1 || params[:quantity].nil?
      render json: {error: 'missing params'}, status: :bad_request
    else
      @merchants = Merchant.revenue_of_the_top(params[:quantity].to_i)
      render json: RevenueSerializer.new(@merchants).serializable_hash
    end
  end

  def weekly
    @revenues = Invoice.weekly_revenue
    render json: WeeklyRevenueSerializer.new(@revenues)
  end

  def merchant
    @revenue = Merchant.revenue(@merchant)
    render json: {
      data: {
        id: "#{@merchant.id}",
        type: :merchant_revenue,
        attributes: {
          revenue: @revenue
        }
      }
    }
  end

  def items
    if params[:quantity].to_i > 0
      @items = Item.revenue_of_the_top(params[:quantity])
      render json: ItemRevenueSerializer.new(@items).serializable_hash
    elsif params[:quantity].nil?
      @items = Item.revenue_of_the_top
      render json: ItemRevenueSerializer.new(@items).serializable_hash
    else
      render json: {error: 'invalid params'}, status: 400
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end


{
  "links": {
    "self": "http://example.com/articles",
    "next": "http://example.com/articles?page[offset]=2",
    "last": "http://example.com/articles?page[offset]=10"
  },
  "data": [{
    "type": "articles",
    "id": "1",
    "attributes": {
      "title": "JSON:API paints my bikeshed!"
    },
    "relationships": {
      "author": {
        "links": {
          "self": "http://example.com/articles/1/relationships/author",
          "related": "http://example.com/articles/1/author"
        },
        "data": { "type": "people", "id": "9" }
      },
      "comments": {
        "links": {
          "self": "http://example.com/articles/1/relationships/comments",
          "related": "http://example.com/articles/1/comments"
        },
        "data": [
          { "type": "comments", "id": "5" },
          { "type": "comments", "id": "12" }
        ]
      }
    },
    "links": {
      "self": "http://example.com/articles/1"
    }
  }],
  "included": [{
    "type": "people",
    "id": "9",
    "attributes": {
      "firstName": "Dan",
      "lastName": "Gebhardt",
      "twitter": "dgeb"
    },
    "links": {
      "self": "http://example.com/people/9"
    }
  }, {
    "type": "comments",
    "id": "5",
    "attributes": {
      "body": "First!"
    },
    "relationships": {
      "author": {
        "data": { "type": "people", "id": "2" }
      }
    },
    "links": {
      "self": "http://example.com/comments/5"
    }
  }, {
    "type": "comments",
    "id": "12",
    "attributes": {
      "body": "I like XML better"
    },
    "relationships": {
      "author": {
        "data": { "type": "people", "id": "9" }
      }
    },
    "links": {
      "self": "http://example.com/comments/12"
    }
  }]
}
