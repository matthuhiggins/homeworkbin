require 'action_controller_test'

class SessionsControllerTest < ActionController::TestCase
  matches_route 'destroy', 'logout#delete'
  matches_route 'new',     'login#get'
  matches_route 'create',  'login#post'

  test 'new' do
    get :new
    assert_template 'new'
  end
  
  test 'invalid credentials' do
    person = Factory.person.create

    post :create, email: person.email, password: 'wrong_sekret'

    assert_equal 'Incorrect e-mail/password', flash[:warning]
    assert_nil @controller.session[:person_id]
    assert_nil @response.cookies['last_login']
    assert_template 'new'
  end
  
  test 'login' do
    person = Factory.person.create
    
    post :create, valid_credentials(person)
    
    assert_logged_in_as person
  end
  
  test 'login with remember_me' do
    person = Factory.person.create

    post :create, valid_credentials(person).update(remember_me: '1')
    
    person.reload
    assert_remembered_as person
  end

  test 'logout' do
    person = Factory.person.create

    delete :destroy, {}, {:person_id => person.id}

    assert @controller.session[:person_id].nil?
  end

  private
    def valid_credentials(person)
      {email: person.email, password: Factory.person.attributes[:password]}
    end
end