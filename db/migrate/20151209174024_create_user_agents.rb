class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string        :web_browser
      t.string        :operating_system
      t.integer       :resolution_width
      t.integer       :resolution_height
      t.string        :ip_address
      t.integer       :client_id
      t.integer       :url_id
    end
  end
end
