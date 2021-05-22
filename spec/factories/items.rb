FactoryBot.define do
  factory :random_item, class: Item do
    name { Faker::Appliance.equipment }
    description { Faker::Lorem.sentence(word_count: 3) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    association :merchant, factory: :random_merchant
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
