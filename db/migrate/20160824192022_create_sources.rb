class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :address
    end
  end
end
