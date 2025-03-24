# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_23_132202) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customized_options", force: :cascade do |t|
    t.integer "cart_item_id", null: false
    t.integer "product_option_id", null: false
    t.integer "product_option_value_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_customized_options_on_cart_item_id"
    t.index ["product_option_id"], name: "index_customized_options_on_product_option_id"
    t.index ["product_option_value_id"], name: "index_customized_options_on_product_option_value_id"
  end

  create_table "product_constraint_values", force: :cascade do |t|
    t.integer "product_constraint_id", null: false
    t.integer "product_option_value_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_constraint_id"], name: "index_product_constraint_values_on_product_constraint_id"
    t.index ["product_option_value_id"], name: "index_product_constraint_values_on_product_option_value_id"
  end

  create_table "product_constraints", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "option_1_id", null: false
    t.integer "option_2_id", null: false
    t.integer "value_1_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_1_id"], name: "index_product_constraints_on_option_1_id"
    t.index ["option_2_id"], name: "index_product_constraints_on_option_2_id"
    t.index ["product_id"], name: "index_product_constraints_on_product_id"
    t.index ["value_1_id"], name: "index_product_constraints_on_value_1_id"
  end

  create_table "product_option_values", force: :cascade do |t|
    t.string "name", null: false
    t.string "value_type"
    t.integer "stock_count", default: 0
    t.integer "product_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_option_id"], name: "index_product_option_values_on_product_option_id"
  end

  create_table "product_options", force: :cascade do |t|
    t.string "name", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_options_on_product_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_types_on_name", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_type_id", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "customized_options", "cart_items"
  add_foreign_key "customized_options", "product_option_values"
  add_foreign_key "customized_options", "product_options"
  add_foreign_key "product_constraint_values", "product_constraints"
  add_foreign_key "product_constraint_values", "product_option_values"
  add_foreign_key "product_constraints", "product_option_values", column: "value_1_id"
  add_foreign_key "product_constraints", "product_options", column: "option_1_id"
  add_foreign_key "product_constraints", "product_options", column: "option_2_id"
  add_foreign_key "product_constraints", "products"
  add_foreign_key "product_option_values", "product_options"
  add_foreign_key "product_options", "products"
  add_foreign_key "products", "product_types"
end
