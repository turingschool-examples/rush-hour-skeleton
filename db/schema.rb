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

ActiveRecord::Schema.define(version: 20160330043930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "identifier"
    t.string   "root_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ips", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payload_requests", force: :cascade do |t|
    t.integer  "url_id"
    t.integer  "referrer_id"
    t.integer  "request_type_id"
    t.integer  "event_id"
    t.integer  "user_agent_id"
    t.integer  "resolution_id"
    t.integer  "ip_id"
    t.string   "requested_at"
    t.integer  "responded_in"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "payload_requests", ["event_id"], name: "index_payload_requests_on_event_id", using: :btree
  add_index "payload_requests", ["ip_id"], name: "index_payload_requests_on_ip_id", using: :btree
  add_index "payload_requests", ["referrer_id"], name: "index_payload_requests_on_referrer_id", using: :btree
  add_index "payload_requests", ["request_type_id"], name: "index_payload_requests_on_request_type_id", using: :btree
  add_index "payload_requests", ["resolution_id"], name: "index_payload_requests_on_resolution_id", using: :btree
  add_index "payload_requests", ["url_id"], name: "index_payload_requests_on_url_id", using: :btree
  add_index "payload_requests", ["user_agent_id"], name: "index_payload_requests_on_user_agent_id", using: :btree

  create_table "referrers", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string   "verb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.string   "width"
    t.string   "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_agents", force: :cascade do |t|
    t.string   "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "platform"
  end

end
