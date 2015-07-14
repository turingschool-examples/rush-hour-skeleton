
ActiveRecord::Schema.define(version: 20150714212110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sites", force: :cascade do |t|
    t.text     "identifier"
    t.text     "root_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
