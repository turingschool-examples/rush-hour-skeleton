require_relative '../test_helper'

class UserSystemTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert UserSystem
  end

  # Web browser breakdown across all requests(userSystem)
  def test_list_browser_breakdown_for_all_requests
    create_payload_1
    create_payload_2
    create_payload_3
    expected = ["Firefox", "Safari"]
    assert_equal expected, UserSystem.browser_breakdown.sort
  end

  # OS breakdown across all requests(userSystem)
  def test_os_browser_breakdown_across_all_requests
    create_payload_1
    create_payload_2
    create_payload_3
    expected = ["Mac OSX", "Windows"]
    assert_equal expected, UserSystem.os_breakdown.sort
  end

  # def test_can_create_resolution_through_payload_request
  #   pr = create_payload_1
  #
  #   assert_equal "960", UserSystem.find(1).
  #   assert_equal "1400", UserSystem.find(1).height
  #   assert_equal 1, pr.resolution_id
  # end
  #
  # def test_can_create_resolutions
  #   res = {width: "960", height: "1400"}
  #   r   = UserSystem.create(res)
  #
  #   assert r.valid?
  #   assert_equal "960", r.width
  #   assert_equal "1400", r.height
  #   assert_equal 1, r.id
  # end
  #
  # def test_the_same_resolution_combo_will_not_be_added_to_database
  #   res = {width: "960", height: "1400"}
  #   r   = UserSystem.create(res)
  #
  #   assert_equal 1, UserSystem.all.count
  #
  #   res2 = {width: "960", height: "1400"}
  #   r2   = UserSystem.create(res2)
  #
  #   assert r2.valid?
  #   refute r2.id.nil?
  #   assert_equal 2, UserSystem.all.count
  # end
  #
  # # Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
  # def test_list_screen_resolutions_across_all_request
  #   create_payload_1
  #   create_payload_2
  #   create_payload_3
  #
  #   expected = [["960", "1400"], ["1920", "1280"]]
  #   assert_equal expected, UserSystem.screen_resolutions
  # end
end
