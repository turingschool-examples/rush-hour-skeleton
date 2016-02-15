class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :request_type
    end
  end
end
