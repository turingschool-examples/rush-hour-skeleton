class CreateSoftwareAgent < ActiveRecord::Migration
  def change
    create_table :software_agent do |t|
      t.string :os
      t.string :browser

      t.timestamps null: false
    end
  end
end
