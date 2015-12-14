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

ActiveRecord::Schema.define(version: 20151211000346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.text "identifier"
    t.text "root_url"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
  end

  create_table "requests", force: :cascade do |t|
    t.text     "request_hash"
    t.integer  "application_id"
    t.datetime "timestamp"
    t.integer  "response_time"
    t.string   "referral"
    t.string   "verb"
    t.string   "browser"
    t.string   "os"
    t.string   "resolution"
    t.integer  "url_id"
    t.integer  "event_id"
  end

  create_table "urls", force: :cascade do |t|
    t.text "path"
  end

end
