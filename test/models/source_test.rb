require 'byebug'
require './test/test_helper'

class SourceTest < Minitest::Test
  attr_reader :source
#don't need rack methods
  def setup
    @source = Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"})
  end

  def test_it_is_not_valid_without_a_title
    id1 = Source.new({root_url: "http://www.jumpstartlab.com"})
    refute id1.valid?
    id1.save
    assert_equal "can't be blank", id1.errors.messages[:identifier].first
  end

  def test_it_is_not_valid_without_a_root_directory
    id2 = Source.new({identifier: "jumpstartlab"})
    refute id2.valid?
    id2.save
    assert_equal "can't be blank", id2.errors.messages[:root_url].first
  end

  def test_it_creates_a_registration
    assert source.valid?
    source.save
  end

  def test_has_many_urls
    url = source.urls.create(url: "anything you want")
    assert_equal 1, Url.count
    assert_equal "anything you want", source.urls.last.url
    assert url.valid?

  end
end
