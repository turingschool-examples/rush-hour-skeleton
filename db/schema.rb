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


# ActiveRecord::Schema.define(version: 20160706215534) do
#
#   These are extensions that must be enabled in order to support this database
#   enable_extension "plpgsql"

  create_table "ips", force: :cascade do |t|
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payload_requests", force: :cascade do |t|
    t.text     "url"
    t.datetime "requested_at"
    t.integer  "responded_in"
    t.text     "referred_by"
    t.string   "request_type"
    t.text     "user_agent"
    t.string   "resolution_width"
    t.string   "resolution_height"
    t.string   "ip"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.text     "root_url"
    t.text     "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
