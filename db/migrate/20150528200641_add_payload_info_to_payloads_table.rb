class AddPayloadInfoToPayloadsTable < ActiveRecord::Migration
  def change
    add_column :payloads, :url,              :text
    add_column :payloads, :requestedat,      :datetime
    add_column :payloads, :respondedin,      :integer
    add_column :payloads, :referredby,       :text
    add_column :payloads, :requesttype,      :text
    add_column :payloads, :eventname,        :text
    add_column :payloads, :useragent,        :text
    add_column :payloads, :resolutionwidth,  :integer
    add_column :payloads, :resolutionheight, :integer
    add_column :payloads, :ip,               :integer
  end
end


