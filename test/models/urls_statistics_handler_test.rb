require_relative '../test_helper'

class UrlsStatisticsHandlerTest < ControllerTest

  def test_it_returns_correct_message_for_incorrect_identifier
    handler = UrlStatisticsHandler.new("no identifier", "meh")
    assert_equal "The no identifier identifier does not exist", handler.message
  end

  def test_it_returns_correct_message_for_incorrect_url
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
    handler = UrlStatisticsHandler.new("facebook", "meh")
    assert_equal "The url meh does not exist.", handler.message
  end

  def test_it_can_return_message_for_valid_url

    handler = UrlStatisticsHandler.new("facebook", "meh")
    handler.check_for_nil_url("meh")
    assert_equal "You're all good!", handler.message

  end

end
