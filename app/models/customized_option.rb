class CustomizedOption < ApplicationRecord
  belongs_to :cart_item
  belongs_to :product_option
  belongs_to :product_option_value, optional: true
end
