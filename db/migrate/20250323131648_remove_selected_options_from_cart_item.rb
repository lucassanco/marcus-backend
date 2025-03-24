class RemoveSelectedOptionsFromCartItem < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :selected_options
  end
end
