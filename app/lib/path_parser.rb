require 'pry'

class PathParser < Sinatra::Base

def self.sources_parser(client, params)
  if client.save
    status 200
    body "{\"identifier\":\"#{client.identifier}\"}"
  elsif params["rootUrl"].nil? || params["identifier"].nil?
    status 400
    body "Missing Parameters"
  else
    status 403
    body client.errors.full_messages.join(", ")
  end
end

def self.sources_identifier_parse(payloads)
  if payloads.empty?
    :client_stats_empty
  else
    :client_stats
  end
end

end
