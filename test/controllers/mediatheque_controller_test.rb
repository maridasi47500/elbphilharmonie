require 'test_helper'

class MediathequeControllerTest < ActionDispatch::IntegrationTest
  test "should get tag" do
    get mediatheque_tag_url
    assert_response :success
  end

end
