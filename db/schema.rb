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

ActiveRecord::Schema.define(version: 20140804212254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "legs", force: true do |t|
    t.integer  "start_location_id", null: false
    t.integer  "end_location_id"
    t.integer  "distance"
    t.string   "distance_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_distance"
  end

  create_table "locations", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "area_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_legs", force: true do |t|
    t.integer  "time"
    t.integer  "leg_id",         null: false
    t.integer  "trip_id",        null: false
    t.integer  "order_position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_time"
  end

  create_table "trips", force: true do |t|
    t.string   "name",                       null: false
    t.integer  "user_id",                    null: false
    t.string   "mode",       default: "car"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "route",      default: [],                 array: true
    t.string   "type"
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
