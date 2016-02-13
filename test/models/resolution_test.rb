require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert ResolutionTest
  end

  def test_can_create_resolution_through_payload_request
    pr = create_payload_1

    assert_equal "960", Resolution.find(1).width
    assert_equal "1400", Resolution.find(1).height
    assert_equal 1, pr.resolution_id
  end

  def test_can_create_resolutions
    res = {width: "960", height: "1400"}
    r   = Resolution.create(res)

    assert r.valid?
    assert_equal "960", r.width
    assert_equal "1400", r.height
    assert_equal 1, r.id
  end

  def test_the_same_resolution_combo_will_not_be_added_to_database
    res = {width: "960", height: "1400"}
    r   = Resolution.create(res)

    assert_equal 1, Resolution.all.count

    res2 = {width: "960", height: "1400"}
    r2   = Resolution.create(res2)

    assert r2.valid?
    refute r2.id.nil?
    assert_equal 2, Resolution.all.count
  end

  # Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
  def test_list_screen_resolutions_across_all_request
    create_payload_1
    create_payload_2
    create_payload_3

    expected = [["960", "1400"], ["1920", "1280"]]
    assert_equal expected, Resolution.screen_resolutions
  end
end
