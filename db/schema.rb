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

ActiveRecord::Schema.define(version: 20150716185055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "browsers", force: :cascade do |t|
    t.string "name"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string "name"
  end

  create_table "payloads", force: :cascade do |t|
    t.string  "digest"
    t.integer "source_id"
    t.integer "url_id"
    t.integer "browser_id"
    t.integer "operating_system_id"
    t.integer "screen_resolution_id"
    t.integer "response_time"
    t.string  "requested_at"
    t.integer "responded_in"
    t.string  "referred_by"
    t.string  "request_type"
    t.integer "event_id"
  end

  create_table "screen_resolutions", force: :cascade do |t|
    t.string "width"
    t.string "height"
  end

  create_table "sources", force: :cascade do |t|
    t.string "identifier"
    t.string "root_url"
  end

  create_table "urls", force: :cascade do |t|
    t.string "address"
  end

end
