class OsTest < Minitest::Test

  def test_it_has_correct_attributes
    os = Os.new(:name => "skittles rain")
    assert_equal "skittles rain", os.name
  end

  def test_it_has_payloads
    os = Os.new(:name => "skittles rain")
    assert_equal [], os.payloads
  end

end
