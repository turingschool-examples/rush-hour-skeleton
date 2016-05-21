require_relative '../test_helper'

class RequestTypeTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_partial_information_is_entered
    request_type = RequestType.new({ })
    refute request_type.save
  end

  def test_it_returns_true_when_all_information_is_entered
    request_type = RequestType.new({ name: "GET!"})
    assert request_type.save
  end

  def test_it_finds_all_verbs_without_repeating_itself
    RequestType.create({ name: "GET"})
    RequestType.create({ name: "GET"})
    RequestType.create({ name: "POST"})
    RequestType.create({ name: "DELETE"})

    assert_equal ["POST", "GET", "DELETE"], RequestType.all_http_verbs
  end

  def test_it_finds_most_common_request_type
    RequestType.create({name: "GET"})
    RequestType.create({name: "GET"})
    RequestType.create({name: "POST"})

    assert_equal ["GET"], RequestType.most_frequent_request_type
  end

end
