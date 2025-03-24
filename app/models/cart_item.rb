class CartItem < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :cart
  belongs_to :product
  has_many :customized_options, dependent: :destroy

  accepts_nested_attributes_for :customized_options

  validate :customized_options_are_valid, on: :create
  
  def selected_options
    customized_options.map {|option| [option.product_option.id, option.product_option_value&.id]}.to_h
  end

  def selected_options_names
    customized_options.map {|option| [option.product_option.name, option.product_option_value&.name]}
  end  

  def product_name
    product.name
  end

  def customized_options_are_valid
    # check constraints
    product.product_constraints.each do |constraint|
      possible_constrainer = customized_options.find do |c_opt|
        c_opt.product_option_id == constraint.option_1_id && c_opt.product_option_value_id == constraint.value_1_id
      end
      if possible_constrainer
        possible_constrainee = customized_options.find do |c_opt|
          c_opt.product_option_id == constraint.option_2_id
        end
        
        if possible_constrainee
          unless constraint.allowed_value_ids.include?(possible_constrainee&.product_option_value_id)
            constrainer_option = ProductOption.find(possible_constrainer.product_option_id)
            constrainee_option = ProductOption.find(possible_constrainee.product_option_id)
            errors.add(:base, "When #{constrainer_option.name} is #{constraint.value_1.name}, the only allowed values for #{constrainee_option.name} are: #{constraint.allowed_values.pluck(:name).to_sentence}")
          end
        end
      end
    end

    # check stock
    out_of_stock_option_value_ids = ProductOptionValue.where(stock_count: 0).pluck(:id)
    customized_options.each do |c_opt|
      if out_of_stock_option_value_ids.include?(c_opt.product_option_value_id)
        errors.add(:base, "#{ProductOptionValue.find(c_opt.product_option_value_id).name} is currently out of stock")
      end
    end
  end
end
