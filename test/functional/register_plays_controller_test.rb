require 'test_helper'

class RegisterPlaysControllerTest < ActionController::TestCase
  setup do
    @register_play = register_plays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:register_plays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create register_play" do
    assert_difference('RegisterPlay.count') do
      post :create, :register_play => @register_play.attributes
    end

    assert_redirected_to register_play_path(assigns(:register_play))
  end

  test "should show register_play" do
    get :show, :id => @register_play.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @register_play.to_param
    assert_response :success
  end

  test "should update register_play" do
    put :update, :id => @register_play.to_param, :register_play => @register_play.attributes
    assert_redirected_to register_play_path(assigns(:register_play))
  end

  test "should destroy register_play" do
    assert_difference('RegisterPlay.count', -1) do
      delete :destroy, :id => @register_play.to_param
    end

    assert_redirected_to register_plays_path
  end
end
