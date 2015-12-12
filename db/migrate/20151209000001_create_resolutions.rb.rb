class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string   :dimension
    end
  end
end
