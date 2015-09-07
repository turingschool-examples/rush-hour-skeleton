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

ActiveRecord::Schema.define(version: 20150905221456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "browsers", force: :cascade do |t|
    t.text     "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "source_id"
  end

  create_table "payloads", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "digest"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "url_id"
    t.integer  "resolution_id"
    t.integer  "browser_id"
    t.integer  "response_id"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string   "resolution_height"
    t.string   "resolution_width"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "responses", force: :cascade do |t|
    t.datetime "requested_at"
    t.integer  "responded_in"
    t.inet     "ip"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sources", force: :cascade do |t|
    t.text     "identifier"
    t.text     "root_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.text     "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "source_id"
  end

end
