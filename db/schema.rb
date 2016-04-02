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

ActiveRecord::Schema.define(version: 20160401153824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.text "identifier"
    t.text "root_url"
  end

  create_table "events", force: :cascade do |t|
    t.text "name"
  end

  create_table "ips", force: :cascade do |t|
    t.text "address"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.date    "requested_at"
    t.integer "url_id"
    t.integer "request_type_id"
    t.integer "user_agent_id"
    t.integer "resolution_id"
    t.integer "ip_id"
    t.integer "referral_id"
    t.integer "event_id"
    t.integer "response_time"
    t.integer "client_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.text "root_url"
    t.text "path"
  end

  create_table "request_types", force: :cascade do |t|
    t.text "verb"
  end

  create_table "resolutions", force: :cascade do |t|
    t.text "width"
    t.text "height"
  end

  create_table "response_times", force: :cascade do |t|
    t.integer "time"
  end

  create_table "urls", force: :cascade do |t|
    t.text "root_url"
    t.text "path"
  end

  create_table "user_agents", force: :cascade do |t|
    t.text "browser"
    t.text "os"
  end

end
