require 'test_helper'

class InterviewControllerTest < ActionController::TestCase
  test "should get admin_all_interview" do
    get :admin_all_interview
    assert_response :success
  end

  test "should get admin_procedure_interview" do
    get :admin_procedure_interview
    assert_response :success
  end

  test "should get user_all_interview" do
    get :user_all_interview
    assert_response :success
  end

  test "should get user_procedure_interview" do
    get :user_procedure_interview
    assert_response :success
  end

end
