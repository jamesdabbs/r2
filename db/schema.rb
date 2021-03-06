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

ActiveRecord::Schema.define(version: 20151206220604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "managers", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "unit_id",    null: false
  end

  add_index "managers", ["unit_id"], name: "index_managers_on_unit_id", using: :btree
  add_index "managers", ["user_id"], name: "index_managers_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "photographable_id",   null: false
    t.string   "photographable_type", null: false
    t.string   "path",                null: false
    t.text     "description"
    t.datetime "created_at",          null: false
  end

  add_index "photos", ["photographable_id"], name: "index_photos_on_photographable_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.integer  "unit_id",     null: false
    t.string   "name",        null: false
    t.string   "rent"
    t.string   "description"
    t.date     "available_on"
    t.boolean  "hidden",      null: false, default: false
  end

  add_index "rooms", ["unit_id"], name: "index_rooms_on_unit_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "beds_and_baths"
    t.string   "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",     null: false
    t.boolean  "deployer", null: false, default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "managers", "units"
  add_foreign_key "managers", "users"
  add_foreign_key "rooms", "units"
end
