require './test/test_helper'

class UrlTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_has_a_url
    url = Url.create({ :page => "http://jumpstartlab.com/blog" })
    assert_equal "http://jumpstartlab.com/blog", url.page
  end

  def test_it_validates_url_presence
    url = Url.create({ :page => "" })
    refute url.valid?
  end

  def test_it_validates_uniqueness
    Url.create({ :page => "http://jumpstartlab.com/blog" })
    Url.create({ :page => "http://jumpstartlab.com/about" })
    Url.create({ :page => "http://jumpstartlab.com/tutorials" })
    Url.create({ :page => "http://jumpstartlab.com/blog" })
    assert_equal 4, Url.count
  end

end
