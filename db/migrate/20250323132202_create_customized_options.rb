class CreateCustomizedOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :customized_options do |t|
      t.references :cart_item, null: false, foreign_key: true
      t.references :product_option, null: false, foreign_key: true
      t.references :product_option_value, null: true, foreign_key: true

      t.timestamps
    end
  end
end
