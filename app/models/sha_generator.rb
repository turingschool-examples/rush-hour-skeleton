require 'json'
require 'pry'

module TrafficSpy
  class ShaGenerator
    def self.create_sha(input)
      sha_message= ""
      input.keys.map do |key|
        sha_message << input[key].to_s
      end
      Digest::SHA1.hexdigest(sha_message)
    end
  end
end
