# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_04_211852) do

  create_table "import_files", force: :cascade do |t|
    t.string "file", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_count", default: 0
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_name", null: false
    t.string "description", null: false
    t.decimal "value", precision: 8, scale: 2, null: false
    t.integer "quantity", null: false
    t.string "address"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "import_file_id"
  end

end
