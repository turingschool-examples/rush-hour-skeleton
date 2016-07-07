require_relative '../test_helper'

class SoftwareAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_software_agent_instance
    software_agent = create_software_agent
    address = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"

    assert_equal address, software_agent.message
  end

  def test_software_agent_relationship_to_payload_requests
    create_payload(1)
    software_agent = SoftwareAgent.first
    software_agent.payload_requests << PayloadRequest.all.first

    refute software_agent.payload_requests.empty?
    software_agent.payload_requests.exists?(software_agent.id)
    assert_equal 1, software_agent.payload_requests.size
  end

end
