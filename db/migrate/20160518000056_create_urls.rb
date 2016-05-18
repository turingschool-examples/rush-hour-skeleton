class CreateUrls < ActiveRecord::Migration
  def change
    create_table "urls" do |t|
      t.string :name
    end

    create_table "url_times" do |t|
      t.belongs_to :url, index: true
      t.belongs_to :time, index: true
    end

    create_table "times" do |t|
      t.string :requested_at
      t.string :responded_in
    end

    remove_column "payload_requests", :url
    remove_column "payload_requests", :requested_at
    remove_column "payload_requests", :responded_in

    add_column "payload_requests", :url_id, :integer

  end
end
