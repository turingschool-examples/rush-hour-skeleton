class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table   :request_types do |t|
      t.string     :request_type
    end
  end
end
