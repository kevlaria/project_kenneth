# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150118065140) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "starts_at"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "condition"
  end

  add_index "events", ["starts_at"], name: "index_events_on_starts_at"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "nests", force: true do |t|
    t.string   "product"
    t.integer  "temperature"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "nests", ["event_id"], name: "index_nests_on_event_id"

  create_table "orders", force: true do |t|
    t.text     "manifest"
    t.string   "pickup_name"
    t.string   "pickup_address"
    t.string   "pickup_phone_number"
    t.string   "pickup_business_name"
    t.text     "pickup_notes"
    t.string   "dropoff_name"
    t.string   "dropoff_address"
    t.string   "dropoff_phone_number"
    t.string   "dropoff_business_name"
    t.text     "dropoff_notes"
    t.string   "quote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmation",          default: false, null: false
    t.string   "access"
    t.integer  "event_id"
  end

  add_index "orders", ["event_id"], name: "index_orders_on_event_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "phone"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weathers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "city"
    t.string   "state"
  end

  add_index "weathers", ["event_id"], name: "index_weathers_on_event_id"

end
