class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string    :path
      t.string    :referred_by
      t.string    :request_type
      t.string    :parameters
      t.integer   :client_id

      t.timestamps null: false
    end
  end
end
