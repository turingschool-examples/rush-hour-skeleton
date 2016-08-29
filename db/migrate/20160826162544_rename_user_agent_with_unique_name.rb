class RenameUserAgentWithUniqueName < ActiveRecord::Migration
  def change
    rename_table('user_agents', 'systems_informations')
  end
end
