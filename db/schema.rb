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

ActiveRecord::Schema.define(version: 20150222020112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "browsers", force: :cascade do |t|
    t.text "name"
  end

  create_table "events", force: :cascade do |t|
    t.text "name"
  end

  create_table "ip_addresses", force: :cascade do |t|
    t.text "address"
  end

  create_table "os", force: :cascade do |t|
    t.text "name"
  end

  create_table "payloads", force: :cascade do |t|
    t.text    "requested_at"
    t.integer "responded_in"
    t.integer "request_type_id"
    t.integer "ip_address_id"
    t.integer "event_id"
    t.integer "resolution_id"
    t.integer "browser_id"
    t.integer "os_id"
    t.integer "source_id"
    t.string  "raw_data"
    t.integer "url_id"
    t.integer "referred_by_id"
  end

  create_table "referred_bies", force: :cascade do |t|
    t.text "name"
  end

  create_table "request_types", force: :cascade do |t|
    t.text "verb"
  end

  create_table "resolutions", force: :cascade do |t|
    t.text "height"
    t.text "width"
  end

  create_table "sources", force: :cascade do |t|
    t.text "identifier"
    t.text "rootUrl"
  end

  create_table "urls", force: :cascade do |t|
    t.text "address"
  end

end
