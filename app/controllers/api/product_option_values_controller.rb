module Api
  class ProductOptionValuesController < ApplicationController
    before_action :set_product_option_values

    def index; end

    private

    def set_product_option_values
      @product_option_values = ProductType.find(params[:product_type_id]).products.find(params[:product_id]).product_option_values
    end
  end
end