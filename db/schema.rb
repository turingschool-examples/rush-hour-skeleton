
ActiveRecord::Schema.define(version: 20160518012914) do

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

  create_table "urls", force: :cascade do |t|
    t.text "address"
  end

  create_table "user_agent_bs", force: :cascade do |t|
    t.string "browser"
    t.string "version"
    t.string "platform"
  end

end
