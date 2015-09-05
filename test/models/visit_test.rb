require_relative '../test_helper'

class VisitTest < Minitest::Test

  def test_it_creates_a_visit_with_valid_attributes
    visit = Visit.new(attributes)

    assert visit.valid?
    visit.save
    assert_equal 1, Visit.count
  end

  def test_it_does_not_create_visit_if_missing_attributes
    attributes = {referred_by: "http://www.jumpstartlab.com/about"}
    visit = Visit.new(attributes)

    refute visit.valid?
    visit.save
    assert_equal 0, Visit.count
  end

  def test_it_does_not_create_visit_with_non_unique_attribute
    visit = Visit.new(attributes)
    visit2 = Visit.new(attributes)


    assert visit.valid?
    visit.save
    refute visit2.valid?
    visit2.save
    assert_equal 1, Visit.count
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def attributes
    {requested_at: "#{Time.now}",
    responded_in: 35,
    referred_by: "http://jumpstartlab.com",
    request_type: "GET",
    parameters: "[]",
    event_name: "IDontCare",
    user_agent: "STUFF!",
    resolution_width: "1920",
    resolution_height: "1080",
    ip: "1.2.3",
    sha_identifier: "1",
    source_id: 1,
    url_id: 1}
  end

end
