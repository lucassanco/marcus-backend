class AddProductTypeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :product_type, null: false, foreign_key: true
  end
end
