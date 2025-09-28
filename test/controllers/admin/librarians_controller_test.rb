require "test_helper"

class Admin::LibrariansControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_librarians_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_librarians_create_url
    assert_response :success
  end
end
