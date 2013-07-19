require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "logged in user redirects to home path" do
    user = User.create(email: "test@example.com", password: "1234")
    sign_in user
    get :index
    assert_redirected_to user_root_path
  end
end
