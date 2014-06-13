require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  setup do
    @address = addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, address: { city: @address.city, country: @address.country, landmark: @address.landmark, line_1: @address.line_1, line_2: @address.line_2, nick_name: @address.nick_name, pincode: @address.pincode, profile_detail_id: @address.profile_detail_id, state: @address.state }
    end

    assert_redirected_to address_path(assigns(:address))
  end

  test "should show address" do
    get :show, id: @address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @address
    assert_response :success
  end

  test "should update address" do
    patch :update, id: @address, address: { city: @address.city, country: @address.country, landmark: @address.landmark, line_1: @address.line_1, line_2: @address.line_2, nick_name: @address.nick_name, pincode: @address.pincode, profile_detail_id: @address.profile_detail_id, state: @address.state }
    assert_redirected_to address_path(assigns(:address))
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, id: @address
    end

    assert_redirected_to addresses_path
  end
end
