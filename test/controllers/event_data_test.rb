require_relative '../test_helper'
require_relative '../../app/models/params_checker'

class EventDataTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods
  include ParamsChecker




end
