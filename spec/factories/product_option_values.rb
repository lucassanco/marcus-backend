FactoryBot.define do
  factory :product_option_value do
    association :product_option
    name { "Full Suspension" }
    stock_count { 10 }
  end
end
