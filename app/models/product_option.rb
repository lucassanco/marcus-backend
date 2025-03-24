class ProductOption < ApplicationRecord
  belongs_to :product
  has_many :product_option_values#, dependent: :destroy

  has_many :constraints_as_constrainer, class_name: "ProductConstraint", foreign_key: "option_1_id"#, dependent: :destroy
  has_many :constraints_as_constrainee, class_name: "ProductConstraint", foreign_key: "option_2_id"#, dependent: :destroy

  accepts_nested_attributes_for :product_option_values, allow_destroy: true

  validates_presence_of :name

  before_destroy :ensure_correct_destroy_order
  
  def values
    product_option_values
  end

  private
  
  def ensure_correct_destroy_order
    destroy_constraints_as_constrainee
    destroy_constraints_as_constrainer
    destroy_product_option_values
  end
  
  def destroy_product_option_values
    product_option_values.destroy_all
  end

  def destroy_constraints_as_constrainer
    constraints_as_constrainer.destroy_all
  end

  def destroy_constraints_as_constrainee
    constraints_as_constrainee.destroy_all
  end
end
