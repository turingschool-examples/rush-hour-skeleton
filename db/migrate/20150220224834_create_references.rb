class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.text :link
    end
  end
end
