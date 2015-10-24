require './test/test_helper'

class ValidatorTest < Minitest::Test


  def test_validate_url_method_can_identify_when_the_url_is_not_in_database
    sources = TrafficSpy::Source
    sources.create({identifier: "jumpstartlab",
                                 root_url: "http://jumpstartlab.com"})
    sources.create({identifier: "yahoo",
                                 root_url: "http://yahoo.com"})

    assert TrafficSpy::Validator.validate_url('yahoo')
    refute TrafficSpy::Validator.validate_url('reddit')
  end

end
