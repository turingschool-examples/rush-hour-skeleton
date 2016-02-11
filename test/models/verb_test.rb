require_relative '../test_helper'

class VerbTest < Minitest::Test
  include TestHelpers

  def test_it_has_request_type_attribute
    verb = Verb.new

    assert_respond_to verb, :request_type
  end
end
