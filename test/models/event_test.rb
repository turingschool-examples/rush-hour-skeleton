class EventTest < Minitest::Test
  def test_it_has_correct_attributes
    event = Event.new(:name => "skittles rain")
    assert_equal "skittles rain", event.name
  end

  def test_it_has_payloads
    event = Event.new(:name => "skittles rain")
    assert_equal [], event.payloads
  end
end
