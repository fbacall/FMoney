# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_30_142310) do

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "parent_category_id"
    t.string "colour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "rules", force: :cascade do |t|
    t.integer "source_id", null: false
    t.string "field"
    t.text "regex"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "priority", default: 0
    t.index ["source_id"], name: "index_rules_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "title"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["category_id"], name: "index_sources_on_category_id"
    t.index ["user_id"], name: "index_sources_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "position"
    t.date "date"
    t.string "transaction_type"
    t.text "description"
    t.decimal "value", precision: 8, scale: 2
    t.decimal "balance", precision: 8, scale: 2
    t.string "account_name"
    t.string "account_number"
    t.integer "source_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["source_id"], name: "index_transactions_on_source_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "rules", "sources"
  add_foreign_key "sources", "categories"
  add_foreign_key "transactions", "sources"
end
