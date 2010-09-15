require 'test_helper'

class PageTextTemplatesControllerTest < ActionController::TestCase
  setup do
    @page_text_template = page_text_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_text_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_text_template" do
    assert_difference('PageTextTemplate.count') do
      post :create, :page_text_template => @page_text_template.attributes
    end

    assert_redirected_to page_text_template_path(assigns(:page_text_template))
  end

  test "should show page_text_template" do
    get :show, :id => @page_text_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @page_text_template.to_param
    assert_response :success
  end

  test "should update page_text_template" do
    put :update, :id => @page_text_template.to_param, :page_text_template => @page_text_template.attributes
    assert_redirected_to page_text_template_path(assigns(:page_text_template))
  end

  test "should destroy page_text_template" do
    assert_difference('PageTextTemplate.count', -1) do
      delete :destroy, :id => @page_text_template.to_param
    end

    assert_redirected_to page_text_templates_path
  end
end
