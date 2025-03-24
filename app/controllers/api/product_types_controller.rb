module Api
  class ProductTypesController < ApplicationController
    before_action :set_product_type, only: %i[show update destroy products]
    before_action :set_products, only: :products

    def index
      @product_types = ProductType.all
    end

    def show; end

    def create
      @product_type = ProductType.new(product_type_params)

      if @product_type.save
        render :create, status: :created
      else
        render 'api/shared/errors', locals: { entity: @product_type }, status: :unprocessable_entity
      end
    end

    def update
      if @product_type.update(product_type_params)
        render :update, status: :ok
      else
        render 'api/shared/errors', locals: { entity: @product_type }, status: :unprocessable_entity
      end
    end
    
    def destroy
      @product_type.destroy
    end

    def products; end

    private 

    def set_product_type
      @product_type = ProductType.find(params[:id])
    end

    def product_type_params
      params.require(:product_type).permit(:name, :description)
    end

    def set_products
      @products = @product_type.products
    end
  end
end