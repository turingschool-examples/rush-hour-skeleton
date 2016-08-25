class FixPayloadProblems < ActiveRecord::Migration
  def change
    remove_columns :payload_requests, :visitor_id, :request_id
  end
end
