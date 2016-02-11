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

ActiveRecord::Schema.define(version: 20160211003835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ip_addresses", force: :cascade do |t|
    t.string "ip"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.string  "requested_at"
    t.integer "responded_in"
    t.integer "resolution_id"
    t.integer "referrer_id"
    t.integer "url_request_id"
    t.integer "user_agent_id"
    t.string  "event_name"
    t.integer "ip_address_id"
    t.integer "verb_id"
  end

  create_table "referrers", force: :cascade do |t|
    t.string "referred_by"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "resolution_width"
    t.string "resolution_height"
  end

  create_table "url_requests", force: :cascade do |t|
    t.string "url"
    t.string "parameters"
  end

  create_table "user_agents", force: :cascade do |t|
    t.string "browser"
    t.string "os"
  end

  create_table "verbs", force: :cascade do |t|
    t.string "request_type"
  end

end
