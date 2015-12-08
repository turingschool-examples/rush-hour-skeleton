class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :identifier_name
      t.string :root_url
    end
  end
end
