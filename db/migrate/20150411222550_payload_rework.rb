class PayloadRework < ActiveRecord::Migration
  def change
    create_table :event_name do |t|
      t.string :event_name
    end

    create_table :request_type do |t|
      t.string :request_type
    end

    add_column :payloads, :source_id, :integer
    add_column :payloads, :request_type_id, :integer
    add_column :payloads, :event_name_id, :integer
    remove_column :payloads, :request_type
    remove_column :payloads, :event_name
    remove_column :payloads, :referred_by
    add_column :payloads, :referred_by_id, :integer

    create_table :referred_by do |t|
      t.string :referred_by_url
    end
  end

end
