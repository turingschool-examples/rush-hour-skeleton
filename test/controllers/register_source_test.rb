require_relative '../test_helper'

class RegisterSourceTest < ControllerTest
  def test_registers_source_with_valid_attributes
    initial_count = Source.count
    post('/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" })
    final_count = Source.count

    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    assert_equal 1, final_count - initial_count
  end

  def test_returns_error_for_missing_paramaters
    initial_count = Source.count
    post('/sources', {rootUrl: "http://jumpstartlab.com" })
    final_count = Source.count

    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
    assert_equal final_count, initial_count
  end

  def test_returns_error_for_existing_identifier
    initial_count = Source.count
    post('/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" })
    post('/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" })
    final_count = Source.count
    assert_equal 403, last_response.status
    assert_equal "Identifier already exists", last_response.body
    assert_equal 1, final_count - initial_count
  end
end
