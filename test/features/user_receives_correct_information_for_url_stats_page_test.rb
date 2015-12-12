require_relative '../test_helper'

class UserReceivesCorrectInformationForURLStatsPageTest < FeatureTest

  def test_user_sees_error_that_url_does_not_exist_when_it_hasnt_been_recorded

    Client.create(name: "Turing", root_url: "http://turing.io")

    visit '/sources/Turing/urls/pretzels'

    assert page.has_content?("That URL has not been requested.")
  end

  def test_user_sees_url_statistics_when_url_has_been_recorded

    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/google/urls/blog'

    assert "/sources/google/urls/blog", current_path
    assert page.has_content?("What?")
  end

end
