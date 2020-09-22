require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "ul.nav"
    get signup_path
    assert_select "title", full_title("Sign up")  
  end
  # test "the truth" do
  #   assert true
  # end
end
