require_relative '../test_helper'

class ReferredByTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_impartial_information_is_entered
    referred = ReferredBy.new({ })
    refute referred.save
  end

  def test_it_returns_true_when_impartial_information_is_entered
    referred = ReferredBy.new({ name: "referred bies!"})
    assert referred.save
  end

end
