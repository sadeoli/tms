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

ActiveRecord::Schema[7.0].define(version: 2022_10_12_184839) do
  create_table "calculations", force: :cascade do |t|
    t.integer "service_order_id", null: false
    t.integer "transportation_modal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_order_id"], name: "index_calculations_on_service_order_id"
    t.index ["transportation_modal_id"], name: "index_calculations_on_transportation_modal_id"
  end

  create_table "costs", force: :cascade do |t|
    t.integer "category"
    t.integer "maximum"
    t.integer "minimum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_price"
    t.integer "transportation_modal_id", null: false
    t.index ["transportation_modal_id"], name: "index_costs_on_transportation_modal_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "code"
    t.string "pickup_address"
    t.string "product_code"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "recipient_name"
    t.string "recipient_address"
    t.string "recipient_phone"
    t.integer "distance"
    t.integer "delivery_time"
    t.integer "status", default: 0
    t.integer "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id"
    t.date "delivery_date"
    t.date "ship_date"
    t.string "delay_reason"
    t.index ["vehicle_id"], name: "index_service_orders_on_vehicle_id"
  end

  create_table "timescales", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "deadline"
    t.integer "transportation_modal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transportation_modal_id"], name: "index_timescales_on_transportation_modal_id"
  end

  create_table "transportation_modals", force: :cascade do |t|
    t.string "name"
    t.integer "max_distance"
    t.integer "min_distance"
    t.integer "max_weight"
    t.integer "min_weight"
    t.integer "flat_rate"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "access_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "model"
    t.string "brand"
    t.integer "max_weight"
    t.integer "manufacture_year"
    t.integer "transportation_modal_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transportation_modal_id"], name: "index_vehicles_on_transportation_modal_id"
  end

  add_foreign_key "calculations", "service_orders"
  add_foreign_key "calculations", "transportation_modals"
  add_foreign_key "costs", "transportation_modals"
  add_foreign_key "service_orders", "vehicles"
  add_foreign_key "timescales", "transportation_modals"
  add_foreign_key "vehicles", "transportation_modals"
end
