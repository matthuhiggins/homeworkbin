require 'test_helper'

class MarketingControllerTest < ActionController::TestCase
  def test_static_views
    %w(index).each do |view|
      get view
      assert_response :ok
    end
  end
end