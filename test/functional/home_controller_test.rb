require 'action_controller_test'

class HomeControllerTest < ActionController::TestCase
  matches_route 'index', '#get'

  test 'index when unauthenticated' do
    get 'index'
    
    assert_template 'unauthenticated'
  end
  
  test 'index when authenticated' do
    person = Factory.person.create

    get :index, {}, {person_id: person.to_param}

    assert_template 'authenticated'
  end
end