class AddGadgetInspectorToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :gadget_inspector, :text
  end
end
