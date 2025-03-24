class ProductConstraintValue < ApplicationRecord
  belongs_to :product_constraint
  belongs_to :product_option_value
end
