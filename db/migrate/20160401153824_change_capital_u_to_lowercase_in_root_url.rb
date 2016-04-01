class ChangeCapitalUToLowercaseInRootUrl < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.remove   :rootUrl
      t.text     :root_url
    end
  end
end
