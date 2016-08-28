class RenameIpAttributeName < ActiveRecord::Migration
  def change
    rename_column(:ips, :ip, :address)
  end
end
