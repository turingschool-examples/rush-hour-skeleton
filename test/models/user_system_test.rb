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

  def test_can_create_user_systems_through_payload_request
    pr = create_payload_1

    assert_equal "Firefox", UserSystem.find(1).browser_type
    assert_equal "Mac OSX", UserSystem.find(1).operating_system
    assert_equal 1, pr.resolution_id
  end

  def test_can_user_system
    sys = {browser_type: "Firefox", operating_system: "Macintosh", unique_sha: Digest::SHA1.hexdigest("1")}
    us   = UserSystem.create(sys)

    assert us.valid?
    assert_equal "Firefox", us.browser_type
    assert_equal "Macintosh", us.operating_system
    assert_equal "356a192b7913b04c54574d18c28d46e6395428ab", us.unique_sha
    assert_equal 1, us.id
  end

  def test_the_same_user_system_combo_will_not_be_added_to_database
    sys = {browser_type: "Firefox", operating_system: "Macintosh", unique_sha: Digest::SHA1.hexdigest("1")}
    us   = UserSystem.create(sys)

    assert_equal 1, UserSystem.all.count

    sys2 = {browser_type: "Firefox", operating_system: "Macintosh", unique_sha: Digest::SHA1.hexdigest("1")}
    us2   = UserSystem.create(sys2)

    assert us2.valid?
    refute us2.id.nil?
    assert_equal 2, UserSystem.all.count
  end  

end
