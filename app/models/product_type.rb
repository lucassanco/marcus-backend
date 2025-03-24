class ProductType < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true

  before_destroy :ensure_correct_destroy_order

  private

  def ensure_correct_destroy_order
    products.each do |product|
      CartItem.where(product_id: product.id).destroy_all
      ProductConstraintValue.where(product_option_value_id: product.product_option_ids).destroy_all
      ProductConstraint
        .where(option_1_id: product.product_option_ids)
        .or(ProductConstraint.where(option_2_id: product.product_option_ids))
        .destroy_all
      
      ProductOptionValue.where(product_option_id: product.product_option_ids).destroy_all
      product.product_options.destroy_all

      product.destroy
    end
  end
end
