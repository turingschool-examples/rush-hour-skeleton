class CreateAgent < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.text :agent
    end
  end
end
