class AddShawColumnsToClientAndPayload < ActiveRecord::Migration
  def change
    add_column "clients", :sha, :string
    add_column "payload_requests", :sha, :string
  end
end
