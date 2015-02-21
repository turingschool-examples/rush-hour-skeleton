class ChangeRequestTypeHttpVerbColumn < ActiveRecord::Migration
  def change
    rename_column :request_types, :http_verbs, :http_verb
  end
end
