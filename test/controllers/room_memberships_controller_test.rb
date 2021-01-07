require 'test_helper'

class RoomMembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get room_memberships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get room_memberships_destroy_url
    assert_response :success
  end

end
