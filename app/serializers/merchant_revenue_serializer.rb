class MerchantRevenueSerializer

  def initialize(merchant, revenue)
    @merchant = merchant
    @revenue = revenue
  end

  def serialize
    {
     data: {
       id: "#{@merchant.id}",
       type: :merchant_revenue,
       attributes: {
         revenue: @revenue
       }
     }
   }
  end
end
