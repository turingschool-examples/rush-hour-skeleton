require_relative '../test_helper'

class TargetUrlTest < Minitest::Test
  include TestHelpers

  def test_can_be_created_wih_name
    data = { name: "http://jumpstartlab.com/blog" }

    url = TargetUrl.create(data)

    assert_equal "http://jumpstartlab.com/blog", url.name
    assert url.valid?
  end

  def test_is_invalid_with_missing_name
    url = TargetUrl.create({ name: nil})

    assert url.name.nil?
    refute url.valid?
  end

  def test_it_only_adds_unique_data
    data = { name: "http://jumpstartlab.com/blog" }

    assert_equal 0, TargetUrl.count

    url_1 = TargetUrl.create(data)

    assert_equal 1, TargetUrl.count
    assert url_1.valid?

    url_2 = TargetUrl.create(data)

    assert_equal 1, TargetUrl.count
    refute url_2.valid?
  end
end
