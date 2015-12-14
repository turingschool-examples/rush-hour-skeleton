class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.text :identifier
      t.text :root_url
    end
  end
end
