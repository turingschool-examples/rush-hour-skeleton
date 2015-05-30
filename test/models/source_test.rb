require_relative '../test_helper'

class SourceTest < Minitest::Test
  def test_valid_with_identifier_and_root_url
    source = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert_equal "jumpstartlab", source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
    assert source.valid?
  end

  def test_valid_uniqueness_of_identifier
    source_one = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    source_two = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert source_one.valid?
    refute source_two.valid?
    assert_equal 1, Source.count
  end

  def test_invalid_without_identifier
    source = Source.create(root_url: "http://jumpstartlab.com")

    refute source.valid?
  end

  def test_invalid_without_root_url
    source = Source.create(identifier: "jumpstartlab")

    refute source.valid?
  end

  def test_group_urls_will_return_hash_with_count_as_value
    Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0710"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0720"})
    source = Source.find_by(identifier: "jumpstartlab")

    assert_equal 1, source.group_urls.last[1]
    assert_equal 2, source.group_urls.first[1]
  end
end
