class PayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.belongs_to :url, index: true
      t.belongs_to :referrer, index: true
      t.belongs_to :request_type, index: true
      t.belongs_to :event, index: true
      t.belongs_to :u_agent, index: true
      t.belongs_to :resolution, index: true
      t.belongs_to :ip, index: true
      t.string     :requested_at
      t.integer    :responded_in

      t.timestamps null: false
    end
  end
end
