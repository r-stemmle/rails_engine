class Api::V1::RevenueController < ApplicationController
  def merchants
    if params[:quantity].to_i < 1 || params[:quantity].nil?
      render json: {error: 'missing params'}, status: :bad_request
    else
      @merchants = Merchant.revenue_of_the_top(params[:quantity].to_i)
      render json: RevenueSerializer.new(@merchants).serializable_hash
    end
  end
end
