require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_responds_to_payloads
    e = Url.create(address: "http://www.google.com")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Url.create(address: "http://www.google.com")

    assert_equal "http://www.google.com", e.address
  end

  def test_wont_validate_incorrect_data
    e = Url.create
    assert_nil e.id

    d = Url.new address: nil
    assert_nil d.address
  end

  def test_list_frequency_of_URLS_from_most_to_least
    setup_1
    expected = {"http://jumpstartlab.com"=>2, "http://jumpstartlab.com/jumps"=>1}
    assert_equal expected, Url.list_frequency_urls
  end


end
