require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get albums_create_url
    assert_response :success
  end

  test "should get index" do
    get albums_index_url
    assert_response :success
  end

  test "should get show" do
    get albums_show_url
    assert_response :success
  end

  test "should get play" do
    get albums_play_url
    assert_response :success
  end

  test "should get destroy" do
    get albums_destroy_url
    assert_response :success
  end
end
