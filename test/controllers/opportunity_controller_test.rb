require 'test_helper'

class OpportunityControllerTest < ActionController::TestCase
  test "should get find_all" do
    get :find_all
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
