class AddCompositeKey < ActiveRecord::Migration
  def change
    add_column :payloads, :composite_key, :string
  end
end
