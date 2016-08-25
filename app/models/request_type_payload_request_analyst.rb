require './app/models/request_type'
require './app/models/payload_request'
class RequestTypePayloadRequestAnalyst
  def most_frequent_request_type
    grouping = group_by_request_type
    RequestType.find_by(:id => grouping[grouping.keys.max]).verb
  end

  def list_verbs
    group_by_request_type.keys.uniq.map do |request_type_id|
      RequestType.find_by(:id => request_type_id).verb
    end
  end

  def group_by_request_type
    PayloadRequest.group('request_type_id').count
  end
end
