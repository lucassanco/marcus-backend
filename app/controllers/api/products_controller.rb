module Api
  class ProductsController < ApplicationController
    before_action :set_products, only: :index
    before_action :set_product, except: %i[index create]

    def index; end

    def show; end

    def create
      @product = Product.new(product_params)

      if @product.save
        render :create, status: :created
      else
        render 'api/shared/errors', locals: { entity: @product }, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
    end

    def update
      if @product.update(product_params)
        render :update, status: :ok
      else
        render 'api/shared/errors', locals: { entity: @product }, status: :unprocessable_entity
      end
    end

    private 

    def set_product
      @product = ProductType.find(params[:product_type_id]).products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :product_type_id)
    end

    def set_products
      @products = ProductType.find(params[:product_type_id]).products
    end
  end
end