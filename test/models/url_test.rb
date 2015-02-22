require './test/test_helper'

class UrlTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_has_a_url
    url = Url.create({ :page => "http://jumpstartlab.com/blog" })
    assert url.page
  end


end