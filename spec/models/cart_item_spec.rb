require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:product_type) { create(:product_type) }
  let(:product) { create(:product, product_type:) }
  let(:cart) { create(:cart) }

  let(:wheels) { create(:product_option, product:, name: "Wheels") }
  let(:frame_type) { create(:product_option, product:, name: "Frame Type") }
  let(:rim_color) { create(:product_option, product:, name: "Rim Color") }

  let(:mountain_wheels) { create(:product_option_value, product_option: wheels, name: "Mountain Wheels") }
  let(:fat_bike_wheels) { create(:product_option_value, product_option: wheels, name: "Fat bike Wheels") }

  let(:full_suspension) { create(:product_option_value, product_option: frame_type, name: "Full Suspension") }
  let!(:diamond) { create(:product_option_value, product_option: frame_type, name: "Diamond") }

  let!(:red) { create(:product_option_value, product_option: rim_color, name: "Red") }
  let(:black) { create(:product_option_value, product_option: rim_color, name: "Black") }
  let(:blue) { create(:product_option_value, product_option: rim_color, name: "Blue", stock_count: 0) }

  let!(:constraint_1) do
    create(:product_constraint, 
      product: product, 
      option_1: wheels, 
      value_1: mountain_wheels, 
      option_2: frame_type, 
      allowed_values: [full_suspension] # Only "Full Suspension" is allowed when "Mountain Wheels" is selected
    )
  end

  let!(:constraint_2) do
    create(:product_constraint, 
      product: product, 
      option_1: wheels, 
      value_1: fat_bike_wheels, 
      option_2: rim_color, 
      allowed_values: [black, blue] # "Red" is unavailable when "Fat Bike Wheels" is selected
    )
  end

  describe "with valid configurations >" do
    let(:valid_cart_item) do
      CartItem.create(
        cart:,
        product:,
        customized_options_attributes: [{
            product_option_id: wheels.id,
            product_option_value_id: mountain_wheels.id
          },
          {
            product_option_id: frame_type.id,
            product_option_value_id: full_suspension.id
          },
          {
            product_option_id: rim_color.id,
            product_option_value_id: red.id
          },
        ]
      )
    end

    it "is valid" do
      expect(valid_cart_item).to be_valid
    end
  end

  describe "with not valid configuration >" do
    context "with constraints >" do
      let(:constrained_cart_item) do
        CartItem.create(
          cart:,
          product:,
          customized_options_attributes: [{
              product_option_id: wheels.id,
              product_option_value_id: fat_bike_wheels.id
            },
            {
              product_option_id: rim_color.id,
              product_option_value_id: red.id
            }
          ]
        )
      end
  
      it "is not valid" do
        expect(constrained_cart_item).not_to be_valid
      end
  
      it "has errors" do
        expect(constrained_cart_item.errors).not_to be_empty
      end 
    end

    context "with out of stock >" do
      let(:out_of_stock_cart_item) do
        CartItem.create(
          cart:,
          product:,
          customized_options_attributes: [{
              product_option_id: wheels.id,
              product_option_value_id: fat_bike_wheels.id
            },
            {
              product_option_id: rim_color.id,
              product_option_value_id: blue.id
            }
          ]
        )
      end
  
      it "is not valid" do
        expect(out_of_stock_cart_item).not_to be_valid
      end
  
      it "has errors" do
        expect(out_of_stock_cart_item.errors).not_to be_empty
      end 
    end    
  end
end
