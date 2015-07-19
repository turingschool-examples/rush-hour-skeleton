require_relative '../test_helper'

class AppStatsHandlerTest < ControllerTest

  def test_it_renders_the_correct_error_page
  app_stats = AppDataHandler.new("test")

  assert_equal "The test identifier does not exist", app_stats.message

  end

end
