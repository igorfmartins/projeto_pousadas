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

ActiveRecord::Schema[7.1].define(version: 2023_12_08_035938) do
  create_table "guests", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "cpf"
    t.index ["email"], name: "index_guests_on_email", unique: true
    t.index ["reset_password_token"], name: "index_guests_on_reset_password_token", unique: true
  end

  create_table "inns", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.integer "cnpj"
    t.integer "contact_phone"
    t.string "email"
    t.string "full_address"
    t.string "state"
    t.string "city"
    t.integer "zip_code"
    t.text "description"
    t.integer "rooms_max"
    t.boolean "pets_accepted"
    t.boolean "breakfast"
    t.boolean "camping"
    t.string "accessibility"
    t.text "policies"
    t.string "payment_methods"
    t.time "check_in_time"
    t.time "check_out_time"
    t.boolean "active"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inns_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "daily_rate"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_prices_on_room_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "reservation_id", null: false
    t.integer "rating"
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", null: false
    t.string "status"
    t.index ["reservation_id"], name: "index_ratings_on_reservation_id"
    t.index ["room_id"], name: "index_ratings_on_room_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "number_of_guests"
    t.string "status"
    t.integer "room_id", null: false
    t.integer "guest_id"
    t.string "confirmation_code"
    t.integer "inn_id"
    t.boolean "active_stay"
    t.datetime "checkin_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "checkout_datetime"
    t.decimal "total_paid"
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "dimension"
    t.integer "max_occupancy"
    t.decimal "daily_rate"
    t.boolean "bathroom"
    t.boolean "balcony"
    t.boolean "air_conditioning"
    t.boolean "tv"
    t.boolean "wardrobe"
    t.boolean "safe"
    t.boolean "accessible"
    t.boolean "available"
    t.integer "inn_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inn_id"], name: "index_rooms_on_inn_id"
  end

  create_table "user_responses", force: :cascade do |t|
    t.integer "rating_id", null: false
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rating_id"], name: "index_user_responses_on_rating_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "inns", "users"
  add_foreign_key "prices", "rooms"
  add_foreign_key "ratings", "reservations"
  add_foreign_key "ratings", "rooms"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "rooms", "inns"
  add_foreign_key "user_responses", "ratings"
end
