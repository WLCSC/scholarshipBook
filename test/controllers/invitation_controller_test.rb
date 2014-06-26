require 'test_helper'

class InvitationControllerTest < ActionController::TestCase
  test "should get generate" do
    get :generate
    assert_response :success
  end

  test "should get apply" do
    get :apply
    assert_response :success
  end

end
