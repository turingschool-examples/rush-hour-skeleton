class CreateUrlRequests < ActiveRecord::Migration
  def change
    create_table :url_requests do |t|
      t.string :url
      t.string :requestType
      t.string :parameters
    end
  end
end
