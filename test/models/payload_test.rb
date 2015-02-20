require './test/test_helper'

class PayloadTest < Minitest::Test

  def test_creates_empty_payload
    Payload.create
    assert_equal 1, Payload.count
  end

  def test_payload_assigns_source_id
    Payload.create({:source_id => 5})
    assert_equal 5, Payload.find(1).source_id
  end

  def teardown
    DatabaseCleaner.clean
  end

end
