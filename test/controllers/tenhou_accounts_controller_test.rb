require 'test_helper'

class TenhouAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenhou_accounts_index_url
    assert_response :success
  end

  test "should get show" do
    get tenhou_accounts_show_url
    assert_response :success
  end

end
