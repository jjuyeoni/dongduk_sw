require 'test_helper'

class MatchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get match_index_url
    assert_response :success
  end

  test "should get result" do
    get match_result_url
    assert_response :success
  end

end
