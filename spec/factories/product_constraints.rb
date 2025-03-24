FactoryBot.define do
  factory :product_constraint do
    association :product
    #association :option_1, factory: :product_option
    #association :value_1, factory: :product_option_value
    #association :option_2, factory: :product_option, name: "otta"
    option_1 { association :product_option, product: product, name: "option_1"}
    value_1 { association :product_option_value, product_option: option_1, name: "value_1"}
    option_2 { association :product_option, product: product, name: "option_2"}
  end
end
