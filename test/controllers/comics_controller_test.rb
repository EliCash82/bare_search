require 'test_helper'

class ComicsControllerTest < ActionController::TestCase
  setup do
    @comic = comics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comic" do
    assert_difference('Comic.count') do
      post :create, comic: { issue: @comic.issue, name: @comic.name, summary: @comic.summary }
    end

    assert_redirected_to comic_path(assigns(:comic))
  end

  test "should show comic" do
    get :show, id: @comic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comic
    assert_response :success
  end

  test "should update comic" do
    patch :update, id: @comic, comic: { issue: @comic.issue, name: @comic.name, summary: @comic.summary }
    assert_redirected_to comic_path(assigns(:comic))
  end

  test "should destroy comic" do
    assert_difference('Comic.count', -1) do
      delete :destroy, id: @comic
    end

    assert_redirected_to comics_path
  end
end
