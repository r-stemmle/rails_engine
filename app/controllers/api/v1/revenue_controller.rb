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
    render json: MerchantRevenueSerializer.new(@merchant, @revenue).serialize
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
