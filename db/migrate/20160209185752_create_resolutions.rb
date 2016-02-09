class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :resolutionWidth
      t.string :resolutionHeight

      t.timestamps null: false
    end
  end
end
