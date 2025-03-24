class CreateProductOptionValues < ActiveRecord::Migration[7.1]
  def change
    create_table :product_option_values do |t|
      t.string :name, null: false
      t.string :value_type
      t.integer :stock_count, default: 0
      t.references :product_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
