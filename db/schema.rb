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

ActiveRecord::Schema.define(version: 20160214011920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "identifier"
    t.string "root_url"
  end

  create_table "event_names", force: :cascade do |t|
    t.string "event_name"
  end

  create_table "ips", force: :cascade do |t|
    t.string "ip_address"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.integer "url_id"
    t.string  "requested_at"
    t.integer "responded_in"
    t.integer "referrer_url_id"
    t.integer "request_type_id"
    t.string  "parameters"
    t.integer "event_name_id"
    t.integer "user_system_id"
    t.integer "ip_id"
    t.integer "resolution_id"
    t.integer "client_id"
    t.string  "unique_sha"
  end

  create_table "referrer_urls", force: :cascade do |t|
    t.string "url_address"
  end

  create_table "request_types", force: :cascade do |t|
    t.string "verb"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "width"
    t.string "height"
    t.string "unique_sha"
  end

  create_table "urls", force: :cascade do |t|
    t.string "address"
  end

  create_table "user_systems", force: :cascade do |t|
    t.string "browser_type"
    t.string "operating_system"
    t.string "unique_sha"
  end

end
