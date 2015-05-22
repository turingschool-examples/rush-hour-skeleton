class CreateTableForApplicationDetails < ActiveRecord::Migration
  def change
    create_table  :urls do |t|
      t.string    :url
      t.string    :requested_at
      t.string    :responded_in
      t.string    :relative_path
    end

    create_table :screen_resolutions do |t|
      t.string   :height
      t.string   :width
    end

    create_table :user_agents do |t|
      t.string   :web_browser
      t.string   :os
    end
  end
end
