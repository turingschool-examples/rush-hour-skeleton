require_relative '../test_helper'

class UrlSysInfoTest < ModelTest

def test_it_can_show_all_operating_systems
  sys_info1 = SystemInformation.create({browser: "Chrome", operating_system: "Windows"})
  sys_info2 = SystemInformation.create({browser: "Internet Explorer", operating_system: "Windows"})
  sys_info3 = SystemInformation.create({browser: "Chrome", operating_system: "iOS"})
  # url_info1 = Url.create({web_address: "http://www.google.com"})
  # url_info2 = Url.create({web_address: "http://www.yahoo.com"})
  # url_info3 = Url.create({web_address: "http://www.espn.com"})
  client1 = Client.create({identifier: "foo", root_url: "bar"})
  client2 = Client.create({identifier: "boo", root_url: "far"})
  PayloadRequest.create({ requested_at: '2016-08-23',
                          responded_in: 3,
                          resolution_id: 1,
                          system_information_id: sys_info1.id,
                          referral_id: 3,
                          ip_id: 4,
                          request_type_id: 5,
                          url_id: 2,
                          client_id: client1.id
                          })
  PayloadRequest.create({ requested_at: '2016-08-25',
                          responded_in: 1,
                          resolution_id: 1,
                          system_information_id: sys_info2.id,
                          referral_id: 1,
                          ip_id: 1,
                          request_type_id: 1,
                          url_id: 3,
                          client_id: client2.id
                          })
  PayloadRequest.create({ requested_at: '2016-08-25',
                          responded_in: 1,
                          resolution_id: 1,
                          system_information_id: sys_info3.id,
                          referral_id: 1,
                          ip_id: 1,
                          request_type_id: 1,
                          url_id: 1,
                          client_id: client2.id
                          })

  expected = {"Windows"=>1}
  assert_equal expected, client1.system_informations.get_all_operating_systems_count
  end
end