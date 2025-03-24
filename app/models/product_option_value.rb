class ProductOptionValue < ApplicationRecord
  belongs_to :product_option

  has_many :product_constraint_values#, dependent: :destroy
  has_many :product_constraints, through: :product_constraint_values#, dependent: :destroy

  validates_presence_of :name

  before_destroy :ensure_correct_destroy_order

  private

  def ensure_correct_destroy_order
    ProductConstraintValue.where(product_option_value_id: self.id).destroy_all
    ProductConstraint
      .where(option_1_id: self.id) # as_constrainer
      .or(ProductConstraint.where(option_2_id: self.id)) # as_constrainee
      .or(ProductConstraint.where(value_1_id: self.id))
      .destroy_all
  end
end
