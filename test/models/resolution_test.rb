require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    resolution = Resolution.new

    assert_respond_to resolution, :resolution_width
    assert_respond_to resolution, :resolution_height
  end

  def test_does_not_save_with_empty_attributes
    resolution = Resolution.new

    refute resolution.save
    refute_equal 1, Resolution.all.count
  end

  def test_resolution_for_all_requests
    create_payload_requests_with_associations(resolution_width: "1920", resolution_height: "1080")
    create_payload_requests_with_associations(resolution_width: "1024", resolution_height: "768")
    create_payload_requests_with_associations(resolution_width: "1024", resolution_height: "768")

    assert_equal [["1920", "1080"], ["1024", "768"]], Resolution.resolution_breakdown
  end
end
