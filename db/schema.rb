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

ActiveRecord::Schema.define(version: 20150408040513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "ip"
  end

  create_table "agents", force: :cascade do |t|
    t.string "userAgent"
  end

  create_table "clients", force: :cascade do |t|
    t.string "identifier"
    t.string "rootUrl"
  end

  create_table "events", force: :cascade do |t|
    t.string "eventName"
  end

  create_table "payloads", force: :cascade do |t|
    t.string   "parameters"
    t.integer  "respondedIn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "requestedAt"
    t.integer  "address_id"
    t.integer  "agent_id"
    t.integer  "client_id"
    t.integer  "event_id"
    t.integer  "referer_id"
    t.integer  "request_id"
    t.integer  "resolution_id"
    t.integer  "tracked_site_id"
  end

  create_table "referers", force: :cascade do |t|
    t.string "referredBy"
  end

  create_table "requests", force: :cascade do |t|
    t.string "requestType"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "resolutionHeight"
    t.string "resolutionWidth"
  end

  create_table "tracked_sites", force: :cascade do |t|
    t.string "url"
  end

end
