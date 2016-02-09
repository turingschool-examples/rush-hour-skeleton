class UpdateForeignKeys < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.rename :id_browser, :browser_id
      t.rename :id_OS, :os_id
      t.rename :id_requestType, :request_type_id
      t.rename :id_screenResolution, :screen_resolution_id
    end
  end
end
