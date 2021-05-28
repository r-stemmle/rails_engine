class Api::V1::RevenueController < ApplicationController

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
