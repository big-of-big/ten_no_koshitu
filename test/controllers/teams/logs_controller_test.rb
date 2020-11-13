require "test_helper"

class Teams::LogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teams_logs_index_url
    assert_response :success
  end
end
