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

ActiveRecord::Schema.define(version: 20151022203516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.text "agent"
  end

  create_table "events", force: :cascade do |t|
    t.text "event_name"
  end

  create_table "ips", force: :cascade do |t|
    t.text "ip"
  end

  create_table "payloads", force: :cascade do |t|
    t.text    "requested_at"
    t.text    "responded_in"
    t.text    "referred_by"
    t.text    "request_type"
    t.text    "resolution_width"
    t.text    "resolution_height"
    t.text    "hex_digest"
    t.integer "source_id"
    t.integer "url_id"
    t.integer "event_id"
    t.integer "agent_id"
    t.integer "ip_id"
  end

  create_table "sources", force: :cascade do |t|
    t.text "identifier"
    t.text "root_url"
  end

  create_table "urls", force: :cascade do |t|
    t.text "url"
  end

end
