class AddWidthResolutionToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :resolution_width, :text
  end
end
