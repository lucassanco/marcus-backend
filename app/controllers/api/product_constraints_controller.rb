module Api
  class ProductConstraintsController < ApplicationController
    before_action :set_constraints, only: :index
    before_action :set_constraint, except: [:index, :create]

    def index; end

    def show; end

    def update
      if product_constraint_params[:allowed_value_ids]
        ActiveRecord::Base.transaction do
          @constraint.product_constraint_values.destroy_all
          product_constraint_values_attributes = []
          product_constraint_params[:allowed_value_ids].each do |product_option_value_id|
            product_constraint_values_attributes << {
              product_option_value_id: product_option_value_id
            }
          end
          constraint_attributes = product_constraint_params.merge({ product_constraint_values_attributes: product_constraint_values_attributes})
          if @constraint.update(constraint_attributes.except(:allowed_value_ids, :product_id))
            render :update, status: :ok
          else
            render 'api/shared/errors', locals: { entity: @constraint }, status: :unprocessable_entity
          end
        end
      else
        if @constraint.update(product_constraint_params.except(:allowed_value_ids))
          render :update, status: :ok
        else
          render 'api/shared/errors', locals: { entity: @constraint }, status: :unprocessable_entity
        end
      end
    end

    def create
      product_constraint_values_attributes = product_constraint_params[:allowed_value_ids].map do |product_option_value_id|
        {
          product_option_value_id:
        }
      end

      constraint_attributes = product_constraint_params.except(:allowed_value_ids).merge({ product_constraint_values_attributes: })

      @constraint = ProductConstraint.new(constraint_attributes)

      if @constraint.save
        render :create, status: :created
      else
        render 'api/shared/errors', locals: { entity: @constraint }, status: :unprocessable_entity
      end
    end

    def destroy
      @constraint.destroy
    end

    private

    def set_constraints
      @constraints = ProductType.find(params[:product_type_id]).products.find(params[:product_id]).product_constraints
    end

    def set_constraint
      @constraint = ProductType.find(params[:product_type_id]).products.find(params[:product_id]).product_constraints.find(params[:id])
    end

    def product_constraint_params
      params.require(:product_constraint).permit(:product_id, :option_1_id, :option_2_id, :value_1_id, allowed_value_ids: [])
    end
  end
end