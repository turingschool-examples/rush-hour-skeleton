class CreatePayload < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string  :url
      t.string  :requestedAt
      t.string  :respondedIn
      t.string  :referredBy
      t.string  :requestType
      t.string  :parameters
      t.string  :eventName
      t.string  :userAgent
      t.integer :resolutionWidth
      t.integer :resolutionHeight
      t.string  :ip
    end

  end
end
#
# payload = {
#   "url":"http://jumpstartlab.com/blog",
#   "requestedAt":"2013-02-16 21:38:28 -0700",
#   "respondedIn":37,
#   "referredBy":"http://jumpstartlab.com",
#   "requestType":"GET",
#   "parameters":[],
#   "eventName": "socialLogin",
#   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1920",
#   "resolutionHeight":"1280",
#   "ip":"63.29.38.211"
# }
