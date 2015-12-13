class ChangeRequestedAtType < ActiveRecord::Migration
  def change
    remove_column(:payloads, :requested_at, :string)
    add_column(:payloads, :requested_at, :datetime)
  end
end
