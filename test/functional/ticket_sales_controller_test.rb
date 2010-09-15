require 'test_helper'

class TicketSalesControllerTest < ActionController::TestCase
  setup do
    @ticket_sale = ticket_sales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_sales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_sale" do
    assert_difference('TicketSale.count') do
      post :create, :ticket_sale => @ticket_sale.attributes
    end

    assert_redirected_to ticket_sale_path(assigns(:ticket_sale))
  end

  test "should show ticket_sale" do
    get :show, :id => @ticket_sale.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ticket_sale.to_param
    assert_response :success
  end

  test "should update ticket_sale" do
    put :update, :id => @ticket_sale.to_param, :ticket_sale => @ticket_sale.attributes
    assert_redirected_to ticket_sale_path(assigns(:ticket_sale))
  end

  test "should destroy ticket_sale" do
    assert_difference('TicketSale.count', -1) do
      delete :destroy, :id => @ticket_sale.to_param
    end

    assert_redirected_to ticket_sales_path
  end
end
