class CreateRespondedInTable < ActiveRecord::Migration
  def change
    create_table :response_times do |t|
      t.integer :time
    end
  end
end
