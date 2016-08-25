require './app/models/request_type'
require './app/models/payload_request'
class RequestTypePayloadRequestAnalyst
  def most_frequent_request_type
    PayloadRequest.where('request_type_id' => 1)
    binding.pry
  end
end
