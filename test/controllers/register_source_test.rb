require_relative '../test_helper'

class RegisterSourceTest < ControllerTest
  def test_registers_source_with_valid_attributes
    initial_count = Source.count
    post('/sources', { source: { identifier: "some identifier", rootURL: "some rootURL" }})
    final_count = Source.count

    assert_equal 200, last_response.status
    assert_equal "Your source was registered", last_response.body
    assert_equal 1, final_count - initial_count
  end
end
