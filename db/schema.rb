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

ActiveRecord::Schema.define(version: 20160329163515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payload_requests", force: :cascade do |t|
    t.date    "requested_at"
    t.integer "url_id"
    t.integer "responded_in_id"
    t.integer "referred_by_id"
    t.integer "request_type_id"
    t.integer "parameter_id"
    t.integer "event_name_id"
    t.integer "user_agent_id"
    t.integer "resolution_id"
    t.integer "ip_id"
  end

end
