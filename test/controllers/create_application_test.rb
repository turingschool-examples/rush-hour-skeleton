require_relative '../test_helper'

class CreateApplicationTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    post '/sources', {application: {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}}


    assert_equal 200, last_response.status
    assert_equal 1, Application.count
    assert_equal "jumpstartlab", Application.all.last.identifier

    assert_equal "Application created.", last_response.body
  end

  def test_application_is_not_created_with_missing_idenfifier
    post '/sources', {application: {root_url: "http://jumpstartlab.com"}}

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
  end

  def test_application_with_missing_idenfifier_returns_missing_id_message
    post '/sources', {application: {root_url: "http://jumpstartlab.com"}}

    assert_equal "Missing identifier.", last_response.body
  end

  def test_application_is_not_created_with_missing_root_url
    post '/sources', {application: {identifier: "jumpstartlab"}}

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
  end

  def test_application_with_missing_url_returns_missing_url_message
    post '/sources', {application: {identifier: "jumpstartlab"}}

    assert_equal "Missing rootUrl.", last_response.body
  end

  def test_application_is_not_created_with_exiting_identifier
    post '/sources', {application: {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}}
    post '/sources', {application: {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}}

    assert_equal 403, last_response.status
    assert_equal 1, Application.count
    assert_equal "Identifier already exists.", last_response.body
  end
end

# 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'

# class CreateGenreTest < Minitest::Test
#   def test_create_genre_with_valid_attributes
#     # Rack test makes it possible for us to send this request
#     # Sinatra packages the input in a large hash
#
#     post '/genres', { genre: { name: "Cartoon" } }
#
#     assert_equal 200, last_response.status # status
#     assert_equal 1, Genre.count # does it exist in the database
#     assert_equal "Genre created.", last_response.body # body content
#   end
#
#   def test_genre_is_not_created_when_missing_name
#     post '/genres', { genre: {} }
#
#     assert_equal 400, last_response.status
#     assert_equal 0, Genre.count
#     assert_equal "Missing title.", last_response.body
#   end
# end
