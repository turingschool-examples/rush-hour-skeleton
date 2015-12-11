require_relative '../test_helper'

class UrlTest < Minitest::Test

  def url_data
    {
      path: 'http://jumpstartlab.com'
    }
  end

  def test_is_created_with_valid_attributes
    Url.create(url_data)
    assert_equal 'http://jumpstartlab.com', Url.last.path
  end

  def test_is_not_created_without_path
    url = Url.new(path: nil)

    refute url.save
  end

  def test_is_not_created_with_duplicated_path
    Url.create(url_data)
    Url.create(url_data)

    assert_equal 1, Url.all.count
  end


  def test_has_many_requests
    url = Url.create(url_data)
    Request.create(url_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(url_id: 1,request_hash: Digest::SHA1.hexdigest("2"))

    assert_equal 2, url.requests.count
  end
end
