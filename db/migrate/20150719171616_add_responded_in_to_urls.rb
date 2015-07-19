class AddRespondedInToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :responded_in, :integer
    add_column :urls, :referred_by, :text
  end
end
