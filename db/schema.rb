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

ActiveRecord::Schema.define(version: 20160517223857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_names", force: :cascade do |t|
    t.string "name"
  end

  create_table "ips", force: :cascade do |t|
    t.string "value"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.datetime "requested_at"
    t.integer  "responded_in"
    t.string   "parameters"
    t.integer  "url_id"
    t.integer  "referrer_id"
    t.integer  "request_type_id"
    t.integer  "event_name_id"
    t.integer  "user_agent_id"
    t.integer  "resolution_id"
    t.integer  "ip_id"
  end

  create_table "referrers", force: :cascade do |t|
    t.string "name"
  end

  create_table "request_types", force: :cascade do |t|
    t.string "verb"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "width"
    t.string "height"
  end

  create_table "urls", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_agents", force: :cascade do |t|
    t.string "browser"
    t.string "platform"
  end

end
