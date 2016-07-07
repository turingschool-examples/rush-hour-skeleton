require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_resolution_instance
    resolution = create_resolution
    width = "1920"
    height = "1280"

    assert_equal width, resolution.width
    assert_equal height, resolution.height
  end

  def test_resolution_relationship_to_payload_requests
    create_payload(1)
    resolution = Resolution.first
    resolution.payload_requests << PayloadRequest.all.first

    refute resolution.payload_requests.empty?
    resolution.payload_requests.exists?(resolution.id)
    assert_equal 1, resolution.payload_requests.size
  end

  def test_it_cannot_create_resolution_without_width
    resolution = Resolution.new(height: "1280")

    refute resolution.valid?
  end

  def test_it_cannot_create_resolution_without_height
    resolution = Resolution.new(width: "640")

    refute resolution.valid?
  end

end
