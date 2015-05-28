require './test/test_helper'

class RegisterSourceTest < ControllersTest

  def test_it_runs
    assert_equal 2, 1+1
  end

  def test_it_posts_to_sources_with_valid_data
    post "/sources", { identifier: "jumpstartlab",
                          rootUrl: "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

  def test_it_returns_an_error_if_missing_identifier_paramater
    error = "Missing parameter, the required parameters are 'identifier' and 'rootUrl'"

    post "/sources", { rootUrl: "http://jumpstartlab.com" }
    assert_equal 400, last_response.status
    assert_equal error, last_response.body

    post "/sources", { identifier: "", rootUrl: "http://jumpstartlab.com" }
    assert_equal 400, last_response.status
    assert_equal error, last_response.body

    post "/sources", { identifier: nil, rootUrl: "http://jumpstartlab.com" }
    assert_equal 400, last_response.status
    assert_equal error, last_response.body
  end

  def test_it_returns_an_error_if_missing_paramater_root_url
    post "/sources", { identifier: "jumpstartlab" }
    assert_equal 400, last_response.status
    assert_equal "Missing parameter, the required parameters are 'identifier' and 'rootUrl'", last_response.body
  end

  def test_it_returns_an_error_if_source_is_already_registered
    post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body

    post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    assert_equal 403, last_response.status
    assert_equal "Identifier already exists", last_response.body
  end
end
