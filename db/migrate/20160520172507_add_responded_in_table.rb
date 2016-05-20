class AddRespondedInTable < ActiveRecord::Migration
  def change
    create_table :responded_ins do |t|
      t.integer :time
    end
  end
end
