require_relative "../test_helper"

class RequestTest < Minitest::Test
    include TestHelpers

  def setup
    @request1 = Request.create({:verb => "GET"})
    @request2 = Request.create({:verb => ""})
  end

  def test_it_validates_new_referrer_with_all_fields
    assert @request1.valid?
  end

  def test_it_does_not_validate_new_referrer_with_missing_fields
    refute @request2.valid?
  end


end
