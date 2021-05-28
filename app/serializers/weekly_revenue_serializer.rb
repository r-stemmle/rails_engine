class WeeklyRevenueSerializer
  include JSONAPI::Serializer
  set_type :weekly_revenue

  attribute :week do |object|
    "#{object.week.strftime("%F")}"
  end

  attribute :revenue do |object|
    object.revenue.round(2)
  end
end
