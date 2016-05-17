class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table "user_agents" do |t|
      t.string    :browser
      t.string    :version
      t.string    :platform
    end
  end
end
