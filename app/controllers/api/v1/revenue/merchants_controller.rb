class Api::V1::Revenue::MerchantsController < ApplicationController
  before_action :set_merchant, only: :show

  def index
    if params[:quantity].to_i < 1 || params[:quantity].nil?
      render json: {error: 'missing params'}, status: :bad_request
    else
      @merchants = Merchant.revenue_of_the_top(params[:quantity].to_i)
      render json: RevenueSerializer.new(@merchants).serializable_hash
    end
  end

  def show
    @revenue = Merchant.revenue(@merchant)
    render json: MerchantRevenueSerializer.new(@merchant, @revenue).serialize
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
