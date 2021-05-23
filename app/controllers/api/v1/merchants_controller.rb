class Api::V1::MerchantsController < ApplicationController

  before_action :set_merchant, only: [:show, :update, :destroy]

  # GET /merchants
  def index
    per_page = params.fetch(:per_page, 20).to_i
    page = [params.fetch(:page, 1).to_i, 1].max
    @merchants = Merchant.offset((page - 1) * per_page).limit(per_page)
    render json: MerchantSerializer.new(@merchants).serializable_hash
  end

  # GET /merchants/1
  def show
    render json: @merchant
  end

  # POST /merchants
  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      render json: @merchant, status: :created, location: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /merchants/1
  def update
    if @merchant.update(merchant_params)
      render json: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /merchants/1
  def destroy
    @merchant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
