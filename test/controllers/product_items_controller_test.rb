require 'test_helper'

class ProductItemsControllerTest < ActionController::TestCase
  setup do
    @product_item = product_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_item" do
    assert_difference('ProductItem.count') do
      post :create, product_item: { available_quantity: @product_item.available_quantity, description: @product_item.description, is_active: @product_item.is_active, price: @product_item.price, title: @product_item.title, user_id: @product_item.user_id }
    end

    assert_redirected_to product_item_path(assigns(:product_item))
  end

  test "should show product_item" do
    get :show, id: @product_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_item
    assert_response :success
  end

  test "should update product_item" do
    patch :update, id: @product_item, product_item: { available_quantity: @product_item.available_quantity, description: @product_item.description, is_active: @product_item.is_active, price: @product_item.price, title: @product_item.title, user_id: @product_item.user_id }
    assert_redirected_to product_item_path(assigns(:product_item))
  end

  test "should destroy product_item" do
    assert_difference('ProductItem.count', -1) do
      delete :destroy, id: @product_item
    end

    assert_redirected_to product_items_path
  end
end
