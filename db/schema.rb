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

ActiveRecord::Schema.define(version: 20160518211433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "identifier"
    t.string "url"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
  end

  create_table "ips", force: :cascade do |t|
    t.string "address"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.text     "requested_at"
    t.integer  "responded_in"
    t.text     "parameters"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "id_url"
    t.string   "id_referrer"
    t.string   "id_request"
    t.string   "id_event"
    t.string   "id_useragent"
    t.string   "id_resolution"
    t.string   "id_ip"
    t.string   "id_client"
  end

  create_table "referrers", force: :cascade do |t|
    t.string "address"
  end

  create_table "requests", force: :cascade do |t|
    t.string "verb"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "width"
    t.string "height"
  end

  create_table "urls", force: :cascade do |t|
    t.text "address"
  end

  create_table "user_agent_bs", force: :cascade do |t|
    t.string "browser"
    t.string "version"
    t.string "platform"
  end

end
