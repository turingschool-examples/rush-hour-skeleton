class AddRequestTypeIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :request_type, index: true, foreign_key: true
  end
end
