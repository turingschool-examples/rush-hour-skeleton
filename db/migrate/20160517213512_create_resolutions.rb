class CreateResolutions < ActiveRecord::Migration
  def change
    create_table "resolutions" do |t|
      t.string    :width
      t.string    :height
    end
  end
end
