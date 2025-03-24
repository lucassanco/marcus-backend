class Product < ApplicationRecord
  belongs_to :product_type

  has_many :product_options, dependent: :destroy
  has_many :product_option_values, through: :product_options

  has_many :product_constraints, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  before_destroy :ensure_correct_destroy_order
  
  def values
    product_option_values
  end

  private

  def ensure_correct_destroy_order
      CartItem.where(product_id: id).destroy_all
      ProductConstraintValue.where(product_option_value_id: product_option_ids).destroy_all
      ProductConstraint
        .where(option_1_id: product_option_ids)
        .or(ProductConstraint.where(option_2_id: product_option_ids))
        .destroy_all
      
      ProductOptionValue.where(product_option_id: product_option_ids).destroy_all
      product_options.destroy_all
  end
end
