require 'action_controller_test'

class SessionsControllerTest < ActionController::TestCase
  matches_route 'destroy', 'logout#delete'
  matches_route 'new',     'login#get'
  matches_route 'create',  'login#post'

  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_invalid_credentials
    person = Factory :person

    post :create, :email => person.email, :password => 'wrong_sekret'

    assert_equal "Incorrect e-mail/password", flash[:warning]
    assert_nil @controller.session[:person_id]
    assert_nil @response.cookies['last_login']
    assert_template 'new'
  end
  
  def test_login
    person = Factory :person
    
    post :create, valid_credentials(person)
    
    assert_logged_in_as person
  end
  
  def test_login_with_remember_me
    person = Factory :person

    post :create, valid_credentials(person).update(:remember_me => '1')
    
    person.reload
    assert_remembered_as person
  end
  
  private
    def valid_credentials(person)
      {:email => person.email, :password => Factory.attributes_for(:person)[:password]}
    end
end