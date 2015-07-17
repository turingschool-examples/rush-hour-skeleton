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

ActiveRecord::Schema.define(version: 20150717003129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "browsers", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_systems", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payloads", force: :cascade do |t|
    t.integer "url_id"
    t.integer "registration_id"
    t.text    "payload_sha"
    t.integer "screen_resolution_id"
    t.integer "browser_id"
    t.integer "operating_system_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.text     "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url"
  end

  create_table "screen_resolutions", force: :cascade do |t|
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", force: :cascade do |t|
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
