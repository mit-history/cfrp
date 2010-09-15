require 'test_helper'

class SeatingCategoriesControllerTest < ActionController::TestCase
  setup do
    @seating_category = seating_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seating_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seating_category" do
    assert_difference('SeatingCategory.count') do
      post :create, :seating_category => @seating_category.attributes
    end

    assert_redirected_to seating_category_path(assigns(:seating_category))
  end

  test "should show seating_category" do
    get :show, :id => @seating_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @seating_category.to_param
    assert_response :success
  end

  test "should update seating_category" do
    put :update, :id => @seating_category.to_param, :seating_category => @seating_category.attributes
    assert_redirected_to seating_category_path(assigns(:seating_category))
  end

  test "should destroy seating_category" do
    assert_difference('SeatingCategory.count', -1) do
      delete :destroy, :id => @seating_category.to_param
    end

    assert_redirected_to seating_categories_path
  end
end
