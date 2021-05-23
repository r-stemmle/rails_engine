class Api::V1::ItemsController < ApplicationController
  ITEMS_PER_PAGE = 20
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @page = params.fetch(:page, 0).to_i
    @items = Item.offset(@page * ITEMS_PER_PAGE).limit(ITEMS_PER_PAGE)
    render json: ItemSerializer.new(@items).serializable_hash.to_json

  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
