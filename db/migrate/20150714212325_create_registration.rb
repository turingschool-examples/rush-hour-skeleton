class CreateRegistration < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.text :identifier

      t.timestamps
    end
  end
end
