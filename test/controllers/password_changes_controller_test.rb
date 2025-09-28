require "test_helper"

class PasswordChangesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get password_changes_edit_url
    assert_response :success
  end

  test "should get update" do
    get password_changes_update_url
    assert_response :success
  end
end
