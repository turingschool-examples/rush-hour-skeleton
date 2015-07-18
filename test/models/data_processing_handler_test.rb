require_relative '../test_helper'

class DataProcessingHandlerTest < Minitest::Test

  def setup
    super

    @identifier = 'identifier'
    RegistrationHandler.new({ "identifier" => @identifier, "rootUrl" => "http://facebook.com" })
  end

  def test_converts_input
    handler = DataProcessingHandler.new(@raw_payload, @identifier)

    assert_equal 'http://jumpstartlab.com/blog', handler.payload[:url]
  end

  def test_returns_403_when_identifier_not_registered
    handler = DataProcessingHandler.new(@raw_payload, 'unregistered_identifier')

    assert_equal 403, handler.status
    assert_equal 'Application Not Registered - 403 Forbidden', handler.body
  end

  def test_returns_400_when_payload_is_missing
    handler = DataProcessingHandler.new({'data' => 'no payload'}, @identifier)

    assert_equal 400, handler.status
    assert_equal 'Missing Payload - 400 Bad Request', handler.body
  end

  def test_returns_200_when_post_successful
    handler = DataProcessingHandler.new(@raw_payload, @identifier)

    assert_equal 200, handler.status
    assert_equal 'Success', handler.body
  end

  def test_payload_saved_when_post_successful
    DataProcessingHandler.new(@raw_payload, @identifier)

    assert_equal  'http://jumpstartlab.com/blog', Url.all.first.url
    assert_equal  1920, ScreenResolution.first.width
    assert_equal  'Chrome', Browser.first.name
    assert_equal  'socialLogin', Event.first.name
    assert_equal  'Macintosh', OperatingSystem.first.name
  end

  def test_unique_payload_identifier_saved
    DataProcessingHandler.new(@raw_payload, @identifier)

    assert_equal 'f5077630df95b6718ac6f032a8360b211f7b3e04', Payload.last.payload_sha
  end

  def test_returns_403_when_duplicate_post
    DataProcessingHandler.new(@raw_payload, @identifier)
    handler = DataProcessingHandler.new(@raw_payload, @identifier)

    assert_equal 403, handler.status
    assert_equal "Already Received Request - 403 Forbidden", handler.body
  end
end
