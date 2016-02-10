class CreateUserAgent < ActiveRecord::Migration
  def change
    create_table :user_agent do |t|
      t.string :browser
      t.string :os
    end
  end
end
