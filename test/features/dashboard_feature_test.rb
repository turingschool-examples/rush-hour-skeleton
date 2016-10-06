require_relative '../test_helper'

class DashboardFeatureTest < FeatureTest
  include TestHelpers


  def create_payload_test
    url            =  Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
    requested_at   =  Time.now
    request_type   =  RequestType.create(verb: "GET")
    resolution     =  Resolution.create(width: "1920", height: "1280")
    referrer       =  Referrer.create(address: "http://jumpstartlab.com")
    software_agent =  SoftwareAgent.create(os: "OSX 10.11.5", browser: "Chrome")
    ip             =  Ip.create(address: "63.29.38.211")
    client         =  Client.find_or_create_by(identifier: "ClientJump", root_url: "www.test.com")
    parameter      =  Parameter.find_or_create_by({user_input: []})

    payload = PayloadRequest.find_or_create_by({
        :url_id => url.id,
        :requested_at => requested_at,
        :responded_in => 69,
        :request_type_id => request_type.id,
        :resolution_id => resolution.id,
        :referred_by_id => referrer.id,
        :software_agent_id => software_agent.id,
        :ip_id => ip.id,
        :parameter_id => parameter.id,
        :client_id => client.id })
  end

  def test_visit_dashboard
    create_payload_test
    visit('/sources/ClientJump')
    page.has_xpath?('/sources/ClientJump')
    assert page.has_content?("You are viewing the data")
    assert has_content?("Most Frequent Request Type")
    assert has_content?("Maximum Response Time")
  end

  def test_click_link
    create_payload_test
    visit('/sources/ClientJump')
    page.has_xpath?('/sources/ClientJump')
    assert page.has_css?("h1")
    assert has_content?("jumpstart")
    page.all(:css, '.most-link').each do |link|
      link.click
    end
  end


end
