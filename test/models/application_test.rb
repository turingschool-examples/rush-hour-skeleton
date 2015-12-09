require_relative '../test_helper'

class ApplicationTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    assert_equal "jumpstartlab", Application.last.identifier
    assert_equal "http://jumpstartlab.com", Application.last.root_url
  end
end
