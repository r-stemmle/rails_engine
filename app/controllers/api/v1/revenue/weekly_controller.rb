class Api::V1::Revenue::WeeklyController < ApplicationController
  def index
    @revenues = Invoice.weekly_revenue
    render json: WeeklyRevenueSerializer.new(@revenues)
  end
end
