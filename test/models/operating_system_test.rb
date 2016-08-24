require_relative '../test_helper'

class OperatingSystemTest < Minitest::Test
  def test_it_can_be_created_with_os_name
    data = { name: "(Macintosh; Intel Mac OS X 10_8_2)" }
    os = OperatingSystem.create(data)

    assert_equal "(Macintosh; Intel Mac OS X 10_8_2)", os.name
    assert os.valid?
  end

  def test_it_is_not_created_if_no_name_is_given
    data = { name: nil }
    os = OperatingSystem.create(data)

    assert_equal nil, os.name
    refute os.valid?
  end

end
