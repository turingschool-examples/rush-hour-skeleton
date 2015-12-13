class AddRelativePathIdInPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :relative_path_id, :integer
  end
end
