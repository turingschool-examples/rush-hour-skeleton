class CorrectTableNameForSystemInformation < ActiveRecord::Migration
  def change
    rename_table('systems_informations', 'system_informations')
  end
end
