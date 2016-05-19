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

ActiveRecord::Schema.define(version: 20160519064005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "identifier"
    t.string "root_url"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
  end

  create_table "ips", force: :cascade do |t|
    t.string "address"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "screen_size_id"
    t.integer  "user_agent_info_id"
    t.integer  "ip_id"
    t.integer  "url_id"
    t.integer  "referred_by_id"
    t.integer  "request_type_id"
    t.datetime "requested_at"
    t.integer  "responded_in"
    t.string   "parameters",         array: true
    t.integer  "event_id"
  end

  create_table "referred_bys", force: :cascade do |t|
    t.string "name"
  end

  create_table "request_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "screen_sizes", force: :cascade do |t|
    t.string "resolution_height"
    t.string "resolution_width"
  end

  create_table "urls", force: :cascade do |t|
    t.string "address"
  end

  create_table "user_agent_infos", force: :cascade do |t|
    t.text   "browser"
    t.string "version"
    t.string "platform"
    t.string "os"
  end

end
