require_relative '../test_helper'

class UrlTest < Minitest::Test

  def test_it_creates_a_url_with_valid_attributes
    url = Url.new(attributes)
    assert url.valid?
    url.save
    assert_equal 1, Url.count
  end

  def test_it_does_not_create_url_if_missing_attributes
    attributes = {source_id: 1}
    url = Url.new(attributes)

    refute url.valid?
    url.save
    assert_equal 0, Url.count
  end

  def test_it_does_not_create_url_with_non_unique_attribute
    url = Url.new(attributes)
    url2 = Url.new(attributes)


    assert url.valid?
    url.save
    refute url2.valid?
    url2.save
    assert_equal 1, Url.count
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def attributes
    {url: "http://jumpstartlab.com/about",
     source_id: 1,
     visits_count: 3,
     average_response_time: 3}
  end

end
