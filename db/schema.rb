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

ActiveRecord::Schema.define(version: 20141004060322) do

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
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "email"
    t.datetime "birth_date"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
