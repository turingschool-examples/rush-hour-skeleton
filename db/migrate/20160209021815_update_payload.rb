 class UpdatePayload < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.remove  :requestType
      t.integer :id_requestType
      t.remove  :userAgent
      t.remove :resolutionWidth
      t.remove :resolutionHeight
      t.integer :id_browser
      t.integer :id_OS
      t.integer :id_screenResolution
    end
  end
end
