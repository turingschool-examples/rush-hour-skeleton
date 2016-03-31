require_relative '../test_helper'

class ClientCreatorTest < Minitest::Test
  include TestHelper

  def test_it_can_create_a_client
    params = {identifier: "jumpstartlab",
                 rootUrl: "www.jumpstartlabs.com"}

    client = ClientCreator.new(params).client

    assert_kind_of Client, client
    assert_equal "jumpstartlab", client.identifier
    assert_equal "www.jumpstartlabs.com", client.rootUrl
  end

  def test_it_wont_create_client_with_invalid_rootUrl
    params = {identifier: "jumpstartlab"}

    client = ClientCreator.new(params).client

    refute client.save
  end

  def test_it_wont_create_client_with_invalid_identifier
    params = {rootUrl: "www.jumpstartlabs.com"}

    client = ClientCreator.new(params).client

    refute client.save
  end

  def test_it_creates_status_and_body_for_new_client
    params = {identifier: "jumpstartlab",
                 rootUrl: "www.jumpstartlabs.com"}

    client_creator = ClientCreator.new(params)

    assert_equal "{\"identifier\":\"jumpstartlab\"}\n", client_creator.body
    assert_equal 200, client_creator.status
  end

  def test_it_creates_status_and_body_for_duplicate_client
    params = {identifier: "jumpstartlab",
                 rootUrl: "www.jumpstartlabs.com"}

    initial_client = ClientCreator.new(params)
    client_creator = ClientCreator.new(params)

    assert_equal "Client with identifier: \"jumpstartlab\" already exists!\n", client_creator.body
    assert_equal 403, client_creator.status
  end

  def test_it_creates_status_and_body_for_invalid_client_with_no_identifier
    params = {identifier: "jumpstartlab"}

    client_creator = ClientCreator.new(params)

    assert_equal "Rooturl can't be blank\n", client_creator.body
    assert_equal 400, client_creator.status
  end

  def test_it_creates_status_and_body_for_invalid_client_with_no_rooturl
    params = {rootUrl: "www.jumpstartlabs.com"}

    client_creator = ClientCreator.new(params)

    assert_equal "Identifier can't be blank\n", client_creator.body
    assert_equal 400, client_creator.status
  end

end
