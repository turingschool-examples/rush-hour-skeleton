require_relative '../test_helper'

class URLTest < Minitest::Test
    include TestHelpers

    def test_can_be_created_wih_url
      data = { name: "http://jumpstartlab.com/blog" }
      url = URL.create(data)
      assert_equal "http://jumpstartlab.com/blog", url.name
      assert url.valid?
    end

    def test_is_invalid_with_missing_url
      url = URL.create({ name: nil})
      assert url.name.nil?
      refute url.valid?
    end
end
