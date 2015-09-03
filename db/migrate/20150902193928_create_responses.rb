class CreateResponses < ActiveRecord::Migration
  def change
    create_table    :responses do |t|
      t.datetime    :requested_at
      t.integer     :responded_in
      t.inet        :ip
      t.integer     :sub_url_id
      t.string      :parameters, array: true

      t.timestamps null: false
    end
  end
end
