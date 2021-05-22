FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { 1.5 }
    merchant { nil }
  end
end



# FactoryBot.define do
#   service_array = ["Test Service", "Test Service Two"]
#   letter = ["a", "b", "c", "d"]
# factory :random_item, class: Item do
#     question { Faker::Lorem.question }
#     answer { Faker::Lorem.sentence }
#     service { service_array.sample }
#     number { Faker::Number.between(1, 2) }
#     letter { letter.sample }
#   end
# end
