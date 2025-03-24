module Api
  class CartItemsController < ApplicationController
    before_action :set_current_cart
    before_action :set_current_cart_item, only: :destroy

    def create
      cart_item_params[:customized_options_attributes] = params[:cart_item][:customized_options_attributes].reject do |option|
        option[:product_option_value_id].nil?
      end
      @cart_item = CartItem.new(cart_item_params.merge({cart_id: @current_cart.id}))
      if @cart_item.save
        render :create, status: :created
      else
        render_errors(@cart_item)
      end
    end

    def index; end

    def destroy
      @cart_item.destroy
    end

    private

    def set_current_cart
      # get cart from current logged user, to simplify I fetch the first Cart on the db
      @current_cart = @current_user&.cart || Cart.first
    end

    def cart_item_params
      params.require(:cart_item).permit(:product_id, customized_options_attributes: [:product_option_id, :product_option_value_id])
    end

    def set_current_cart_item
      @cart_item = @current_cart.cart_items.find(params[:id])
    end
  end
end