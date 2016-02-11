require_relative '../test_helper'

class VerbTest < Minitest::Test
  include TestHelpers

  def test_it_has_request_type_attribute
    verb = Verb.new

    assert_respond_to verb, :request_type
  end

  def test_attribute_must_be_present_when_saving
    verb = Verb.new

    refute verb.save
    refute_equal 1, Verb.all.size end
end
