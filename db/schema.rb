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

ActiveRecord::Schema.define(version: 20151209200854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "root_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "responded_in"
    t.string   "requested_at"
    t.string   "event_name"
    t.integer  "client_id"
    t.integer  "url_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "hexed_payloads", force: :cascade do |t|
    t.string "hexed_payload"
  end

  create_table "urls", force: :cascade do |t|
    t.string   "path"
    t.string   "referred_by"
    t.string   "request_type"
    t.string   "parameters"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_agents", force: :cascade do |t|
    t.string  "web_browser"
    t.string  "operating_system"
    t.integer "resolution_width"
    t.integer "resolution_height"
    t.string  "ip_address"
    t.integer "client_id"
    t.integer "url_id"
  end

end
