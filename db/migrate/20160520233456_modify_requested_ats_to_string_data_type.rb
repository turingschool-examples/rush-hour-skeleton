class ModifyRequestedAtsToStringDataType < ActiveRecord::Migration
  def change
    remove_column :requested_ats, :time

    add_column :requested_ats, :time, :string
  end
end
