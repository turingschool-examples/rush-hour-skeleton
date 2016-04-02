class CreateParametersTable < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.text :params
    end
  end
end
