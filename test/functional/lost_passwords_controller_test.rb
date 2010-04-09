require 'action_controller_test'

class LostPasswordsControllerTest < ActionController::TestCase
  matches_resources 'lost_passwords'
  
  def test_new
    get :new

    assert_kind_of LostPassword, assigns(:lost_password)
  end
  
  def test_create_success
    person = Factory.person.create

    post :create, :lost_password => {
      :email => person.email
    }
    
    assert_template 'confirm'
  end
  
  def test_create_failure
    post :create, :lost_password => {
      :email => 'invalid'
    }
    
    assert_template 'new'
  end
  
  def test_show
    lost_password = Factory.lost_password.create

    get :show, :id => lost_password.token
    
    assert_equal lost_password, assigns(:lost_password)
    assert_equal lost_password.person, assigns(:person)
  end
  
  def test_update_success
    lost_password = Factory.lost_password.create
    
    put :update, :id => lost_password.token, :lost_password => {:new_password => 'snoopy'}
    
    assert_logged_in_as lost_password.person
  end
  
  def test_update_failure
    lost_password = Factory.lost_password.create
    
    put :update, :id => lost_password.token, :lost_password => {:new_password => ''}
    
    assert_template 'show'
  end
end