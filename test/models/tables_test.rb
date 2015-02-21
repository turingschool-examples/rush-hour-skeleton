require "./test/test_helper"

class TableTest < Minitest::Test

  def test_sources_table_exists
    assert Source
  end

  def test_payloads_table_exists
    assert Payload
  end

  def test_urls_table_exists
    assert Url
  end

  def test_referrers_table_exists
    assert Referrer
  end

  def test_request_types_table_exists
    assert RequestType
  end

  def test_ip_addresses_table_exists
    assert IpAddress
  end

  def test_events_table_exists
    assert Event
  end

  def test_resolution_table_exists
    assert Resolution
  end

  def test_browsers_table_exists
    assert Browser
  end

  def test_os_table_exists
    assert Os
  end

end
