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

ActiveRecord::Schema.define(version: 20141004081527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "pod_id"
    t.text     "text_body"
  end

  create_table "pods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pool_id"
  end

  create_table "pods_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "pod_id"
  end

  create_table "pool_profiles", force: true do |t|
    t.text     "goals"
    t.text     "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "pool_id"
  end

  create_table "pools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "location_name"
    t.string   "location_address"
  end

  create_table "swipes", force: true do |t|
    t.boolean "right_swipe", default: false
    t.integer "user_id"
    t.integer "seen_user"
    t.integer "pool_id"
    t.integer "count",       default: 0
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.datetime "birth_date"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
