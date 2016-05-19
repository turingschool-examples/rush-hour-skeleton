class CreateClientTable < ActiveRecord::Migration
  def change
    create_table "clients" do |t|
      t.string      :identifier
      t.string      :root_url
    end
  end

  add_column "payload_requests", "client_id", :integer
    rename_table "referred_bys", "referred_bies"
end
