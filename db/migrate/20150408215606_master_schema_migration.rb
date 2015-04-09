class MasterSchemaMigration < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :ip
    end

    create_table :agents do |t|
      t.string :user_agent
    end

    create_table :clients do |t|
      t.string :identifier
      t.string :root_url
    end

    create_table :events do |t|
      t.string :event_name
    end

    create_table :payloads do |t|
      t.string :parameters
      t.integer :responded_in
      t.string :requested_at
      t.integer :address_id
      t.integer :agent_id
      t.integer :client_id
      t.integer :event_id
      t.integer :referer_id
      t.integer :request_id
      t.integer :resolution_id
      t.integer :tracked_site_id
      t.string :composite_key
    end

    create_table :referers do |t|
      t.string :referred_by
    end

    create_table :requests do |t|
      t.string :request_type
    end

    create_table :resolutions do |t|
      t.string :resolution_height
      t.string :resolution_width
    end

    create_table :tracked_sites do |t|
      t.string :url
    end

  end
end
