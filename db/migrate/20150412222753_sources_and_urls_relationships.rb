class SourcesAndUrlsRelationships < ActiveRecord::Migration
  def change
    create_table :Payloads do |t|
      t.belongs_to :source, index: true
      t.belongs_to :url, index: true
    end
  end
end
