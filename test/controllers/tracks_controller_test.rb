require "test_helper"

class TracksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tracks_create_url
    assert_response :success
  end

  test "should get index" do
    get tracks_index_url
    assert_response :success
  end

  test "should get show" do
    get tracks_show_url
    assert_response :success
  end

  test "should get play" do
    get tracks_play_url
    assert_response :success
  end

  test "should get destroy" do
    get tracks_destroy_url
    assert_response :success
  end
end
