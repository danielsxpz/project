require "test_helper"

class LibrariansControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get librarians_new_url
    assert_response :success
  end

  test "should get create" do
    get librarians_create_url
    assert_response :success
  end
end
