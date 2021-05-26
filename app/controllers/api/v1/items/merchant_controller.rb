class Api::V1::Items::MerchantController < ApplicationController
  before_action :set_item, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :dude_wheres_my_record

  def show
    set_merchant
    render json: MerchantSerializer.new(@merchant).serializable_hash
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_merchant
    @merchant = Merchant.find(@item.merchant_id)
  end

  def dude_wheres_my_record
    # render json: {:status => 404, :error => 'Not Found'}
    render json: {error: 'not found'}, status: 404
  end
end
