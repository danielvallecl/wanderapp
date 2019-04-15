require 'test_helper'

class ActivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active = actives(:one)
  end

  test "should get index" do
    get actives_url
    assert_response :success
  end

  test "should get new" do
    get new_active_url
    assert_response :success
  end

  test "should create active" do
    assert_difference('Active.count') do
      post actives_url, params: { active: { event_id: @active.event_id, obs: @active.obs, status: @active.status, user_id: @active.user_id } }
    end

    assert_redirected_to active_url(Active.last)
  end

  test "should show active" do
    get active_url(@active)
    assert_response :success
  end

  test "should get edit" do
    get edit_active_url(@active)
    assert_response :success
  end

  test "should update active" do
    patch active_url(@active), params: { active: { event_id: @active.event_id, obs: @active.obs, status: @active.status, user_id: @active.user_id } }
    assert_redirected_to active_url(@active)
  end

  test "should destroy active" do
    assert_difference('Active.count', -1) do
      delete active_url(@active)
    end

    assert_redirected_to actives_url
  end
end
