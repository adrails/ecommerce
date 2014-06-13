require 'test_helper'

class ProfileDetailsControllerTest < ActionController::TestCase
  setup do
    @profile_detail = profile_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_detail" do
    assert_difference('ProfileDetail.count') do
      post :create, profile_detail: {  }
    end

    assert_redirected_to profile_detail_path(assigns(:profile_detail))
  end

  test "should show profile_detail" do
    get :show, id: @profile_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_detail
    assert_response :success
  end

  test "should update profile_detail" do
    patch :update, id: @profile_detail, profile_detail: {  }
    assert_redirected_to profile_detail_path(assigns(:profile_detail))
  end

  test "should destroy profile_detail" do
    assert_difference('ProfileDetail.count', -1) do
      delete :destroy, id: @profile_detail
    end

    assert_redirected_to profile_details_path
  end
end
