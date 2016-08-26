require_relative '../test_helper'
require './app/models/system_information'

class SystemInformationTest < ModelTest
  def test_it_validates_input
    sys_info = SystemInformation.new({browser: "Do T Browser",
                                operating_system: "Do T OSX"})

    sys_info_sad = SystemInformation.new({browser: "Sad Do T Browser"})
    assert sys_info.save
    refute sys_info_sad.save
  end

    def test_browser_needs_unique_operating_system
      sys_info = SystemInformation.create({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      sys_info = SystemInformation.new({browser: "Do T Browser",
                                  operating_system: "New OSX"})
      assert sys_info.save
    end

    def test_operating_system_needs_unique_browser
      sys_info = SystemInformation.create({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      sys_info = SystemInformation.new({browser: "Browser",
                                  operating_system: "Do T OSX"})
      assert sys_info.save
    end

    def test_combination_of_operating_system_and_browser_is_unique
      sys_info = SystemInformation.create({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      sys_info = SystemInformation.new({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      refute sys_info.save
    end

    def test_it_can_show_all_browsers
      sys_info1 = SystemInformation.create({browser: "Chrome", operating_system: "Windows"})
      sys_info2 = SystemInformation.create({browser: "Internet Explorer", operating_system: "Windows"})
      sys_info3 = SystemInformation.create({browser: "Chrome", operating_system: "iOS"})
      PayloadRequest.create({ requested_at: '2016-08-23',
                              responded_in: 3,
                              resolution_id: 1,
                              system_information_id: sys_info1.id,
                              referral_id: 3,
                              ip_id: 4,
                              request_type_id: 5,
                              url_id: 2
                              })
      PayloadRequest.create({ requested_at: '2016-08-25',
                              responded_in: 1,
                              resolution_id: 1,
                              system_information_id: sys_info2.id,
                              referral_id: 1,
                              ip_id: 1,
                              request_type_id: 1,
                              url_id: 2
                              })
      PayloadRequest.create({ requested_at: '2016-08-25',
                              responded_in: 1,
                              resolution_id: 1,
                              system_information_id: sys_info3.id,
                              referral_id: 1,
                              ip_id: 1,
                              request_type_id: 1,
                              url_id: 2
                              })
      
      expected = {"Internet Explorer"=>1, "Chrome"=>2}
      assert_equal expected, SystemInformation.get_all_browsers_count
    end

    def test_it_can_show_all_operating_systems
      skip
      sys_info1 = SystemInformation.create({browser: "Chrome", operating_system: "Windows"})
      sys_info2 = SystemInformation.create({browser: "Internet Explorer", operating_system: "Windows"})
      sys_info3 = SystemInformation.create({browser: "Internet Explorer", operating_system: "Windows"})
      sys_info4 = SystemInformation.create({browser: "Chrome", operating_system: "iOS"})
      sys_info4 = SystemInformation.create({browser: "Chrome", operating_system: "iOS"})
    
      assert_equal ["Windows", "Windows", "iOS"], SystemInformation.get_all_operating_systems
    end

  end
