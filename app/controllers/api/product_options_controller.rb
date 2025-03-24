module Api
  class ProductOptionsController < ApplicationController
    before_action :set_product_options, only: :index
    before_action :set_product_option, only: %i[show values destroy update]
    before_action :set_product_option_values, only: :option_values

    def index; end
    def show; end

    def values; end

    def create
      @product_option = ProductOption.new(product_option_params)

      if @product_option.save
        render :create, status: :created
      else
        render 'api/shared/errors', locals: { entity: @product_option }, status: :unprocessable_entity
      end
    end

    def destroy
      @product_option.destroy
    end

    def update
      if @product_option.update(product_option_params)
        render :update, status: :ok
      else
        render 'api/shared/errors', locals: { entity: @product_option }, status: :unprocessable_entity
      end
    end

    def option_values; end

    private

    def set_product_option
      @product_option = ProductType.find(params[:product_type_id]).products.find(params[:product_id]).product_options.find(params[:id])
    end

    def set_product_option_values
      @product_option_values = @product_option.product_option_values
    end

    def product_option_params
      params.require(:product_option).permit(:name, :product_id, product_option_values_attributes: [:id, :name, :stock_count, :_destroy])
    end

    def set_product_options
      @product_options = ProductType.find(params[:product_type_id]).products.find(params[:product_id]).product_options
    end
  end
end