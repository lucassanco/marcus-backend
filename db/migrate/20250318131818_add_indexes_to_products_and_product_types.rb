class AddIndexesToProductsAndProductTypes < ActiveRecord::Migration[7.1]
  def change
    add_index :products, :name, unique: true
    add_index :product_types, :name, unique: true
  end
end
