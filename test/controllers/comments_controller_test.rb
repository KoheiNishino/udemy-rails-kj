require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get comments_destroy_url
    assert_response :success
  end

  test "should get —skip-template-engine" do
    get comments_—skip-template-engine_url
    assert_response :success
  end

end
