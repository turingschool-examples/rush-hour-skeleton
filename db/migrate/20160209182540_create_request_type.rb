class CreateRequestType < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.string :verb
    end
  end
end
