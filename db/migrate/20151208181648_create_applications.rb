class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :identifier
      t.string :root_url
    end
  end
end
