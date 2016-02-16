class CreateOs < ActiveRecord::Migration
  def change
    create_table :os do |t|
      t.string :kind
    end
  end
end
