require 'pry'

module SubTableChecker
  def check_url_exists(formatted_payload)
    if Url.exists?(url: formatted_payload["url"])
      Url.find_by(url: formatted_payload["url"]).id
    else
      Url.create(url: formatted_payload["url"])
      Url.find_by(url: formatted_payload["url"]).id
    end
  end

  def check_referred_by_exists(formatted_payload)
    if ReferredBy.exists?(url: formatted_payload["referred_by"])
      ReferredBy.find_by(url: formatted_payload["referred_by"]).id
    else
      ReferredBy.create(url: formatted_payload["referred_by"])
      ReferredBy.find_by(url: formatted_payload["referred_by"]).id
    end
  end

  def check_request_type_exists(formatted_payload)
    if RequestType.exists?(verb: formatted_payload["request_type"])
       RequestType.find_by(verb: formatted_payload["request_type"]).id
    else
      RequestType.create(verb: formatted_payload["request_type"])
      RequestType.find_by(verb: formatted_payload["request_type"]).id
    end
  end

  def check_u_agent_exists(formatted_payload)
    if UAgent.exists?(agent: formatted_payload["u_agent"])
      UAgent.find_by(agent: formatted_payload["u_agent"]).id
    else
      UAgent.create(agent: formatted_payload["u_agent"])
      UAgent.find_by(agent: formatted_payload["u_agent"]).id
    end
  end

  def check_resolution_exists(formatted_payload)
    if Resolution.exists?(width: formatted_payload["resolution_width"], height: formatted_payload["resolution_height"])
      Resolution.find_by(width: formatted_payload["resolution_width"], height: formatted_payload["resolution_height"]).id
    else
      Resolution.create(width: formatted_payload["resolution_width"], height: formatted_payload["resolution_height"])
      Resolution.find_by(width: formatted_payload["resolution_width"], height: formatted_payload["resolution_height"]).id
    end
  end

  def check_ip_exists(formatted_payload)
    if Ip.exists?(ip_address: formatted_payload["ip"])
      Ip.find_by(ip_address: formatted_payload["ip"]).id
    else
      Ip.create(ip_address: formatted_payload["ip"])
      Ip.find_by(ip_address: formatted_payload["ip"]).id
    end
  end

  def check_client_exists(client_params)
    Client.find_by(identifier: client_params).id
  end
end
