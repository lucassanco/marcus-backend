class CreateProductConstraints < ActiveRecord::Migration[7.1]
  def change
    create_table :product_constraints do |t|
      t.references :product, null: false, foreign_key: true
      t.references :option_1, null: false, foreign_key: { to_table: :product_options }
      t.references :option_2, null: false, foreign_key: { to_table: :product_options }
      t.references :value_1, null: false, foreign_key: { to_table: :product_option_values }

      t.timestamps
    end
  end
end
