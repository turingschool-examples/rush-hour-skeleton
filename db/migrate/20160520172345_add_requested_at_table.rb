class AddRequestedAtTable < ActiveRecord::Migration
  def change
    create_table :request_ats do |t|
      t.datetime :time
    end
  end
end
