class RemoveRepetitivePayloadRequestColumns < ActiveRecord::Migration
  def change
    remove_column(:payload_requests, :ip, :string)
    remove_column(:payload_requests, :resolution_height, :string)
    remove_column(:payload_requests, :resolution_width, :string)
    remove_column(:payload_requests, :user_agent, :text)
    remove_column(:payload_requests, :event_name, :string)
    remove_column(:payload_requests, :request_type, :string)
    remove_column(:payload_requests, :reference, :text)
  end
end
