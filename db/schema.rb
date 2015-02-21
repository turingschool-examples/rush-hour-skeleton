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

ActiveRecord::Schema.define(version: 20150221183951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.text "browser"
    t.text "version"
    t.text "platform"
  end

  create_table "dimensions", force: :cascade do |t|
    t.text "height"
    t.text "width"
  end

  create_table "events", force: :cascade do |t|
    t.text "name"
  end

  create_table "identifiers", force: :cascade do |t|
    t.text "name"
    t.text "root_url"
  end

  create_table "ips", force: :cascade do |t|
    t.text "address"
  end

  create_table "payloads", force: :cascade do |t|
    t.integer "url_id"
    t.text    "requested_at"
    t.text    "responded_in"
    t.integer "referral_id"
    t.integer "request_id"
    t.string  "parameters",    default: [], array: true
    t.integer "event_id"
    t.integer "agent_id"
    t.integer "dimension_id"
    t.integer "ip_id"
    t.integer "identifier_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.text "url"
  end

  create_table "requests", force: :cascade do |t|
    t.text "request_type"
  end

  create_table "urls", force: :cascade do |t|
    t.text "address"
  end

end
