class CreateProductConstraintValues < ActiveRecord::Migration[7.1]
  def change
    create_table :product_constraint_values do |t|
      t.references :product_constraint, null: false, foreign_key: true
      t.references :product_option_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
