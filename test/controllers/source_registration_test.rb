require_relative '../test_helper'

class SourceRegistrationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_valid_registration_with_identifier_and_rooturl
    init_count = Source.count

    post('/sources', { source: { identifier: "anIdentifier", rooturl: "some/root/url"} } )

    ende_count = Source.count

    assert_equal 200, last_response.status
    assert_equal "Registration complete.", last_response.body
    assert_equal 1, (ende_count - init_count)
  end

  def test_invalid_registration_with_no_identifier
    init_count = Source.count

    post('/sources', { source: { rooturl: "some/root/url"} } )

    ende_count = Source.count

    assert_equal 403, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
    assert_equal init_count, ende_count
  end

  def test_invalid_registration_with_no_rooturl
    init_count = Source.count

    post('/sources', { source: { identifier: "anIdentifier"} } )

    ende_count = Source.count

    assert_equal 403, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
    assert_equal init_count, ende_count
  end
end