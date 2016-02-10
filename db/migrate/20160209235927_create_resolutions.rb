class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :resolutionWidth
      t.string :resolutionHeight
    end
  end
end
