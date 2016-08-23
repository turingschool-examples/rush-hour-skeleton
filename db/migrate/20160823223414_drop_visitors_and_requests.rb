class DropVisitorsAndRequests < ActiveRecord::Migration
  def change
    drop_table :visitors
    drop_table :requests
  end
end
