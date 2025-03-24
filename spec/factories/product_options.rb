FactoryBot.define do
  factory :product_option do
    association :product
    name { "Frame Type" }
  end
end
