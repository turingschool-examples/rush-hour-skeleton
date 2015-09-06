class AddOperatingSystemColumnToBrowsers < ActiveRecord::Migration
  def change
    add_column :browsers, :operating_system, :text
  end
end
