class CreateScreenResolution < ActiveRecord::Migration
  def change
    create_table :screen_resolution do |t|
      t.string :size
    end
  end
end
