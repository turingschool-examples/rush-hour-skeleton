ActiveRecord::Schema.define(version: 20160519020051) do

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
    t.string "platform"
  end

end
