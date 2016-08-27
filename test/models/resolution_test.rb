require_relative '../test_helper'
require './app/models/resolution'

class ResolutionTest < ModelTest
  def test_it_validates_input
    resolution = Resolution.new({height: "100",
                                 width: "250"
                                 })

    resolution_sad = Resolution.new({height: "1000"})
    assert resolution.save
    refute resolution_sad.save
    resolution_sad = Resolution.new({width: "1000"})
    refute resolution_sad.save
  end

  def test_width_can_have_unique_heights
    resolution = Resolution.create({height: "100",
                                 width: "250"
                                 })
    resolution = Resolution.new({height: "200",
                                 width: "250"
                                 })

    assert resolution.save
  end

  def test_it_has_unique_width
    resolution = Resolution.create({height: "100",
                                 width: "250"
                                 })
    resolution = Resolution.new({height: "100",
                                 width: "400"
                                 })

    assert resolution.save
  end

  def test_combination_between_height_and_width_is_unique
    resolution = Resolution.create({height: "100",
                                 width: "250"
                                 })
    resolution = Resolution.new({height: "100",
                                 width: "250"
                                 })

    refute resolution.save
  end

  def test_it_can_find_all_resolutions
    resolution1 = Resolution.create({height: "100",
                                 width: "250"
                                 })
    resolution2 = Resolution.create({height: "200",
                                 width: "300"
                                 })
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 5,
                            resolution_id: resolution1.id,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: 2
                            })
                           
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 4,
                            resolution_id: resolution2.id,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: 3
                            })
    assert_equal [["100", "250"], ["200", "300"]], Resolution.get_all_screen_resolutions
  end
end
