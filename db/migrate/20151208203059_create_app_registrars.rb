class CreateAppRegistrars < ActiveRecord::Migration
  def change
    create_table :app_registrars do |t|
      t.string :identifier
    end
  end
end
