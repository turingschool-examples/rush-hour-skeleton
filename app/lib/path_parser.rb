require 'pry'

class PathParser

  def self.sources_parser(client, params)
    if client.save
      {"status" => 200, "body" => "{\"identifier\":\"#{client.identifier}\"}"}
    elsif params["rootUrl"].nil? || params["identifier"].nil?
      {"status" => 400, "body" => "Missing Parameters"}
    else
      {"status" => 403, "body" => client.errors.full_messages.join(", ")}
    end
  end

  def self.sources_identifier_parse(payloads, client)
    if client.nil?
      :client_stats_nonexistant
    elsif payloads.empty?
      :client_stats_empty
    else
      :client_stats
    end
  end

  # def self.relative_path_parser(client, identifier, relative_path)
  #   url = client.root_url + '/' + relative_path
  #   unless Url.pluck(:address).include?(url)
  #     redirect '/missing-url'
  #   else
  #     @url_obj = Url.where(address: url).first
  #     erb :url_stats
  #   end
end
