require 'test_helper'

class MailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mails_new_url
    assert_response :success
  end

  test "should get show" do
    get mails_show_url
    assert_response :success
  end

end
