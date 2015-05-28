class CreatePayloadsTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text       :payhash
      t.text       :url
      t.datetime   :requestedat
      t.integer    :respondedin
      t.text       :referredby
      t.text       :requesttype
      t.varchar    :parameters
      t.text       :eventname
      t.text       :useragent
      t.integer    :resolutionwidth
      t.integer    :resolutionheight
      t.integer    :ip
      t.belongs_to :source
    end
  end
end

