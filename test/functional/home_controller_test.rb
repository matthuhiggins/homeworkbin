require 'action_controller_test'

class HomeControllerTest < ActionController::TestCase
  matches_route 'index', '#get'

  def test_index_when_unauthenticated
    get 'index'
    
    assert_template 'unauthenticated'
  end
  
  def test_index_when_authenticated
    person = Factory.person.create

    get :index, {}, {person_id: person.to_param}

    assert_template 'authenticated'
  end
end