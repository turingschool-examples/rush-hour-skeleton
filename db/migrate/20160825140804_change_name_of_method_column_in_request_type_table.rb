class ChangeNameOfMethodColumnInRequestTypeTable < ActiveRecord::Migration
  def change
    rename_column(:request_types, :method, :http_verb)
  end
end
