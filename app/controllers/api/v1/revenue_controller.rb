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

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
