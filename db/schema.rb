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

ActiveRecord::Schema[7.1].define(version: 2024_09_21_162201) do
  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.float "weight"
    t.integer "unit_id"
    t.integer "store_id", null: false
    t.index ["store_id"], name: "index_items_on_store_id"
    t.index ["unit_id"], name: "index_items_on_unit_id"
  end

  create_table "prices", force: :cascade do |t|
    t.float "value"
    t.float "promo"
    t.date "date", default: "2024-09-21"
    t.integer "item_id"
    t.index ["item_id"], name: "index_prices_on_item_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name", null: false
  end

  add_foreign_key "items", "stores"
  add_foreign_key "items", "units"
  add_foreign_key "prices", "items"
end
