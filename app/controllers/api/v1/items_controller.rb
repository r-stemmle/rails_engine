class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    per_page = params.fetch(:per_page, 20).to_i
    page = [params.fetch(:page, 1).to_i, 1].max
    @items = Item.offset((page - 1) * per_page).limit(per_page)
    render json: ItemSerializer.new(@items).serializable_hash.to_json
  end

  def show
    render json: ItemSerializer.new(@item).serializable_hash
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      render json: ItemSerializer.new(@item).serializable_hash, status: :created, location: api_v1_item_path(@item)
    else
      # require "pry"; binding.pry
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: ItemSerializer.new(@item).serializable_hash
    else
      raise ActionController::RoutingError.new('Not Found')
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
