require 'json'
require 'pry'
require_relative 'sub_table_checker'

class DataParser
  include SubTableChecker
  
  attr_reader :raw_data

  attr_accessor :url,
                :referred_by,
                :request_type,
                :u_agent,
                :resolution,
                :ip,
                :client

  def initialize(raw_data)
    @raw_data     = raw_data
    @url          = url
    @referred_by  = referred_by
    @request_type = request_type
    @u_agent      = u_agent
    @resolution   = resolution
    @ip           = ip
    @client       = client
  end

  def new_keys
    { "requestedAt"=>"requested_at",
      "respondedIn"=>"responded_in",
      "referredBy"=>"referred_by",
      "requestType"=>"request_type",
      "userAgent"=>"u_agent",
      "resolutionWidth"=>"resolution_width",
      "resolutionHeight"=>"resolution_height",
      "rootUrl"=>"root_url"
    }
  end

  def parsed_payload
    JSON.parse(raw_data["payload"])
  end

  def formatted_payload
    parsed_payload.map {|key, value| [new_keys[key] || key, value]}.to_h
  end

  def formatted_client
    raw_data.map {|key, value| [new_keys[key] || key, value]}.to_h
  end

  def populate_tables
    @url = Url.find_or_create_by(url: formatted_payload["url"], path: relative_path(formatted_payload["url"]))
    @referred_by = ReferredBy.find_or_create_by(url: formatted_payload["referred_by"])
    @request_type = RequestType.find_or_create_by(verb: formatted_payload["request_type"])
    @u_agent = UAgent.find_or_create_by(agent: formatted_payload["u_agent"])
    @resolution = Resolution.find_or_create_by(width: formatted_payload["resolution_width"], height: formatted_payload["resolution_height"])
    @ip = Ip.find_or_create_by(ip_address: formatted_payload["ip"])
    @client = Client.find_by(identifier: raw_data["identifier"])
  end

  # def assign_foreign_keys
  #   {:url_id => url.id,
  #   :requested_at => formatted_payload["requested_at"],
  #   :responded_in => formatted_payload["responded_in"],
  #   :referred_by_id => referred_by.id,
  #   :request_type_id => request_type.id,
  #   :u_agent_id => u_agent.id,
  #   :resolution_id => resolution.id,
  #   :ip_id => ip.id,
  #   :client_id => client.id}
  # end

  def assign_foreign_keys
  PayloadRequest.find_or_initialize_by(url_id: url.id,
                        requested_at: formatted_payload["requested_at"],
                        responded_in: formatted_payload["responded_in"],
                        referred_by_id: referred_by.id,
                        request_type_id: request_type.id,
                        u_agent_id: u_agent.id,
                        resolution_id: resolution.id,
                        ip_id: ip.id,
                        client_id: client.id
                        )
  end


  # PayloadRequest.find_by(url_id: found_url.id...)


  # def check_if_payload_exists
  #   populate_tables
  #
  #   assignments = {:url_id => url.id,
  #   :requested_at => formatted_payload["requested_at"],
  #   :responded_in => formatted_payload["responded_in"],
  #   :referred_by_id => referred_by.id,
  #   :request_type_id => request_type.id,
  #   :u_agent_id => u_agent.id,
  #   :resolution_id => resolution.id,
  #   :ip_id => ip.id,
  #   :client_id => client.id}
  #
  #   PayloadRequest.find_by(
  #     url_id: assignments[:url_id],
  #     requested_at: assignments[:requested_at],
  #     responded_in: assignments[:responded_in],
  #     referred_by_id: assignments[:referred_by_id],
  #     request_type_id: assignments[:request_type_id],
  #     u_agent_id: assignments[:u_agent_id],
  #     resolution_id: assignments[:resolution_id],
  #     ip_id: assignments[:ip_id],
  #     client_id: assignments[:client_id]
  #      )
  # end

end
