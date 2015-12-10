require_relative '../test_helper'
require_relative '../simulation_environment/client_environment_simulator'

class UserCanViewApplicationDetailsForRegisteredApplicationTest < FeatureTest

  def test_user_can_view_application_details_for_registered_application
    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/google'

    save_and_open_page
    within '#client_name' do
      assert page.has_content?("google")
    end

  end










end
