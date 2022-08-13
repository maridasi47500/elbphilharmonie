require 'test_helper'

class WhatsonControllerTest < ActionDispatch::IntegrationTest
  test "should get events" do
    get whatson_events_url
    assert_response :success
  end

  test "should get subscriptions" do
    get whatson_subscriptions_url
    assert_response :success
  end

  test "should get season" do
    get whatson_season_url
    assert_response :success
  end

  test "should get participate" do
    get whatson_participate_url
    assert_response :success
  end

end
