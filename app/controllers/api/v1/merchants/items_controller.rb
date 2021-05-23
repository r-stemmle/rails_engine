class Api::V1::Merchants::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    render json: ItemSerializer.new(@items).serializable_hash
  end

  private
    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
