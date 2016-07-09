require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url
    url = Url.create(address:"Turing.io")
    assert_equal "Turing.io", url.address
  end

  def test_urls_from_most_requested_to_least_requested
    create_payload(1)
    create_payload2(2)
    create_payload3(1)

    expected = ["http://turing.io/blog", "http://jumpstartlab.com/blog0", "http://galvanize.com/blog"]
    assert_equal expected, Url.urls_from_most_to_least_requested
  end

  # def create_payload10(integer)
  #   integer.times do |i|
  #     url           = Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
  #     requested_at  = Time.now
  #     request_type  = RequestType.find_or_create_by(verb: "GET")
  #     resolution    = Resolution.find_or_create_by(width: "1366", height: "768")
  #     referrer      = Referrer.find_or_create_by(address: "http://turing.com")
  #     software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.9.0", browser: "Firefox")
  #     ip            = Ip.find_or_create_by(address: "63.29.38.211")
  #
  #     PayloadRequest.find_or_create_by({
  #         :url_id => url.id,
  #         :requested_at => requested_at,
  #         :responded_in => i,
  #         :request_type_id => request_type.id,
  #         :resolution_id => resolution.id,
  #         :referred_by_id => referrer.id,
  #         :software_agent_id => software_agent.id,
  #         :ip_id => ip.id })
  #   end
  # end
  #
  # def create_payload11(integer)
  #   integer.times do |i|
  #     url           = Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
  #     requested_at  = Time.now
  #     request_type  = RequestType.find_or_create_by(verb: "GET")
  #     resolution    = Resolution.find_or_create_by(width: "1366", height: "768")
  #     referrer      = Referrer.find_or_create_by(address: "http://turing.com")
  #     software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.9.1", browser: "Chrome")
  #     ip            = Ip.find_or_create_by(address: "63.29.38.211")
  #
  #     PayloadRequest.find_or_create_by({
  #         :url_id => url.id,
  #         :requested_at => requested_at,
  #         :responded_in => i,
  #         :request_type_id => request_type.id,
  #         :resolution_id => resolution.id,
  #         :referred_by_id => referrer.id,
  #         :software_agent_id => software_agent.id,
  #         :ip_id => ip.id })
  #   end
  # end
  #
#     def create_payload12(integer)
#       integer.times do |i|
#         url           = Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
#         requested_at  = Time.now
#         request_type  = RequestType.find_or_create_by(verb: "GET")
#         resolution    = Resolution.find_or_create_by(width: "1366", height: "768")
#         referrer      = Referrer.find_or_create_by(address: "http://turing.com")
#         software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.9.3", browser: "IE")
#         ip            = Ip.find_or_create_by(address: "63.29.38.211")
#
#         PayloadRequest.find_or_create_by({
#             :url_id => url.id,
#             :requested_at => requested_at,
#             :responded_in => i,
#             :request_type_id => request_type.id,
#             :resolution_id => resolution.id,
#             :referred_by_id => referrer.id,
#             :software_agent_id => software_agent.id,
#             :ip_id => ip.id })
#       end
#     end
#
#     def create_payload13(integer)
#       integer.times do |i|
#         url           = Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
#         requested_at  = Time.now
#         request_type  = RequestType.find_or_create_by(verb: "GET")
#         resolution    = Resolution.find_or_create_by(width: "1366", height: "768")
#         referrer      = Referrer.find_or_create_by(address: "http://turing.com")
#         software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.9.4", browser: "TOR")
#         ip            = Ip.find_or_create_by(address: "63.29.38.211")
#
#         PayloadRequest.find_or_create_by({
#             :url_id => url.id,
#             :requested_at => requested_at,
#             :responded_in => i,
#             :request_type_id => request_type.id,
#             :resolution_id => resolution.id,
#             :referred_by_id => referrer.id,
#             :software_agent_id => software_agent.id,
#             :ip_id => ip.id })
#       end
#     end


#   def test_it_can_pull_three_most_popular_user_agents
#
#     create_payload10(2)
#     binding.pry
#     create_payload11(3)
#     create_payload12(4)
#     create_payload13(5)
#     binding.pry
#     url = Url.find(1)
#
#
#     assert_equal 3, url.popular_agents.length
#
#
#
# end


end
