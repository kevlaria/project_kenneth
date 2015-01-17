require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { dropoff_address: @order.dropoff_address, dropoff_business_name: @order.dropoff_business_name, dropoff_name: @order.dropoff_name, dropoff_notes: @order.dropoff_notes, dropoff_phone_number: @order.dropoff_phone_number, manifest: @order.manifest, pickup_address: @order.pickup_address, pickup_business_name: @order.pickup_business_name, pickup_name: @order.pickup_name, pickup_notes: @order.pickup_notes, pickup_phone_number: @order.pickup_phone_number, quote_id: @order.quote_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { dropoff_address: @order.dropoff_address, dropoff_business_name: @order.dropoff_business_name, dropoff_name: @order.dropoff_name, dropoff_notes: @order.dropoff_notes, dropoff_phone_number: @order.dropoff_phone_number, manifest: @order.manifest, pickup_address: @order.pickup_address, pickup_business_name: @order.pickup_business_name, pickup_name: @order.pickup_name, pickup_notes: @order.pickup_notes, pickup_phone_number: @order.pickup_phone_number, quote_id: @order.quote_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
