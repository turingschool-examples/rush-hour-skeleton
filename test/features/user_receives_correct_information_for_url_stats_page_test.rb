require_relative '../test_helper'

class UserReceivesCorrectInformationForURLStatsPageTest < FeatureTest

  def test_user_sees_error_that_url_does_not_exist_when_it_hasnt_been_recorded

    Client.create(name: "Turing", root_url: "http://turing.io")

    visit '/sources/Turing/urls/pretzels'

    assert page.has_content?("That URL has not been requested.")
  end

  def test_user_sees_url_statistics_when_url_has_been_recorded

    Client.create(name: "jumpstartlab", root_url: "http://jumpstartlab.com")
    ph = PayloadHandler.new(payload)

    visit '/sources/jumpstartlab/urls/blog'

    assert "/sources/jumpstartlab/urls/blog", current_path
    assert page.has_content?("URL Details")
  end

end
