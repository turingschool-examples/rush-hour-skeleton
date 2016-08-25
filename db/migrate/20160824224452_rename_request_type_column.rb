class RenameRequestTypeColumn < ActiveRecord::Migration
  def change
    rename_column(:request_types, :request_type, :method)
  end
end
