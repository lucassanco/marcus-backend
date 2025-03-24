class ProductConstraint < ApplicationRecord
  belongs_to :product

  belongs_to :option_1, class_name: "ProductOption"
  belongs_to :value_1, class_name: "ProductOptionValue"

  belongs_to :option_2, class_name: "ProductOption"

  has_many :product_constraint_values, dependent: :destroy
  has_many :allowed_values, through: :product_constraint_values, source: :product_option_value

  accepts_nested_attributes_for :product_constraint_values

  def option_1_name
    option_1.name
  end

  def option_2_name
    option_2.name
  end

  def value_1_name
    value_1.name
  end

  def allowed_values_names
    allowed_values.pluck(:name).to_sentence.presence || 'None'
  end
end
