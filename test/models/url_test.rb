require 'test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url
    payload = create_payload

    assert payload.url.validates
  end


end
