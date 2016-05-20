class ReAddParametersTable < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string :list
    end
  end
end
