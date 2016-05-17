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

ActiveRecord::Schema.define(version: 20160517213748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payload_requests", force: :cascade do |t|
    t.text     "url"
    t.text     "requested_at"
    t.integer  "responded_in"
    t.string   "request_type"
    t.text     "parameters"
    t.string   "event_name"
    t.string   "ip"
    t.string   "referred_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent_id"
    t.string   "resolution_id"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "width"
    t.string "height"
  end

  create_table "user_agents", force: :cascade do |t|
    t.string "browser"
    t.string "version"
    t.string "platform"
  end

end
