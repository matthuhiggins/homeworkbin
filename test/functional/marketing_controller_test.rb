require 'action_controller_test'

class MarketingControllerTest < ActionController::TestCase
  matches_route 'index', '#get'

  def test_static_views
    %w(index).each do |view|
      get view
      assert_response :ok
    end
  end
  
  def test_redirect_when_authenticated
    person = Factory :person
    get :index, {}, {:person_id => person.to_param}
    assert_response 302
  end
end