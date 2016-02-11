class CreateClient < ActiveRecord::Migration
  def change
    create_table :client do |t|
      t.string :identifier
      t.string :root_url
    end
  end
end
