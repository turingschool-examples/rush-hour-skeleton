class ChangeRequestAtTableName < ActiveRecord::Migration
  def change
    drop_table :request_ats

    create_table :requested_ats do |t|
      t.datetime :time
    end
  end
end
