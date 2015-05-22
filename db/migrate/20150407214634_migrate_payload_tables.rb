class MigratePayloadTables < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :parameters
      t.integer :responded_in
      t.timestamps
    end

    create_table :user_agents do |t|
      t.string :web_browser
      t.string :OS
      t.string :OS_version
    end

    create_table :tracked_sites do |t|
      t.string :url
    end

    create_table :ips do |t|
      t.string :address
    end

    create_table :resolutions do |t|
      t.string :height
      t.string :width
    end

    create_table :events do |t|
      t.string :name
    end

    create_table :referers do |t|
      t.string :url
    end

  end
end
