require 'action_controller_test'

class LostPasswordsControllerTest < ActionController::TestCase
  matches_resources 'lost_passwords'
  
  test 'new' do
    get :new

    assert_kind_of LostPassword, assigns(:lost_password)
  end
  
  test 'create success' do
    person = Factory.person.create

    post :create, lost_password: {
      email: person.email
    }
    
    assert_template 'confirm'
  end
  
  test 'create failure' do
    post :create, lost_password: {
      email: 'invalid'
    }
    
    assert_template 'new'
  end
  
  test 'show' do
    lost_password = Factory.lost_password.create

    get :show, id: lost_password.token
    
    assert_equal lost_password, assigns(:lost_password)
    assert_equal lost_password.person, assigns(:person)
  end
  
  test 'update success' do
    lost_password = Factory.lost_password.create
    
    put :update, id: lost_password.token, lost_password: {new_password: 'snoopy'}
    
    assert_logged_in_as lost_password.person
  end
  
  test 'update failure' do
    lost_password = Factory.lost_password.create
    
    put :update, id: lost_password.token, lost_password: {new_password: ''}
    
    assert_template 'show'
  end
end