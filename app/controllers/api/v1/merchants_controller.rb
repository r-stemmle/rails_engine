class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]

  def index
    per_page = params.fetch(:per_page, 20).to_i
    page = [params.fetch(:page, 1).to_i, 1].max
    @merchants = Merchant.offset((page - 1) * per_page).limit(per_page)
    render json: MerchantSerializer.new(@merchants).serializable_hash
  end

  def show
    render json: MerchantSerializer.new(@merchant).serializable_hash
  end

  private
    def set_merchant
      @merchant = Merchant.find(params[:id]) || not_found
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
