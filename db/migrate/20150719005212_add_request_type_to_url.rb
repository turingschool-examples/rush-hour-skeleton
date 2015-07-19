class AddRequestTypeToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :request_type, :text
  end
end
