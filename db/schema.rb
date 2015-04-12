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

ActiveRecord::Schema.define(version: 20150411222550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_name", force: :cascade do |t|
    t.string "event_name"
  end

  create_table "payloads", force: :cascade do |t|
    t.string  "requested_at"
    t.integer "responded_in"
    t.text    "parameters",           default: [], array: true
    t.string  "ip"
    t.integer "url_id"
    t.integer "user_agent_id"
    t.integer "screen_resolution_id"
    t.integer "source_id"
    t.integer "request_type_id"
    t.integer "event_name_id"
    t.integer "referred_by_id"
  end

  create_table "referred_by", force: :cascade do |t|
    t.string "referred_by_url"
  end

  create_table "request_type", force: :cascade do |t|
    t.string "request_type"
  end

  create_table "screen_resolutions", force: :cascade do |t|
    t.string  "resolution_height"
    t.string  "resolution_width"
    t.integer "user_agent_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "identifier"
    t.string "root_url"
  end

  create_table "urls", force: :cascade do |t|
    t.string  "url"
    t.string  "requested_at"
    t.string  "responded_in"
    t.string  "relative_path"
    t.integer "source_id"
  end

  create_table "user_agents", force: :cascade do |t|
    t.string "web_browser"
  end

end
