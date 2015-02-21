class CreateEightTables < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :url_id
      t.text    :requested_at
      t.text    :responded_in
      t.integer :referred_by_id
      t.integer :request_type_id
      t.string  :parameters, array: true, default: []
      t.integer :event_name_id
      t.integer :user_agent_id
      t.integer :dimension_id
      t.integer :ip_id
    end

    create_table :urls do |t|
      t.text     :address
    end

    create_table :dimensions do |t|
      t.text     :height
      t.text     :width
    end

    create_table :ips do |t|
      t.text     :address
    end

    create_table :user_agents do |t|
      t.text     :environment
    end

    create_table :events do |t|
      t.text     :name
    end

    create_table :requests do |t|
      t.text     :type
    end

    create_table :referred_by do |t|
      t.text     :url
    end

  end
end
