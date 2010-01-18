require 'test_helper'

class LostPasswordsControllerTest < ActionController::TestCase
  def test_new
    get :new

    assert_kind_of LostPassword, assigns(:lost_password)
  end
  
  def test_show
    lost_password = Factory :lost_password

    get :show, :id => lost_password.token
    
    assert_equal lost_password, assigns(:lost_password)
    assert_equal lost_password.person, assigns(:person)
  end
  
  def test_update_success
    # TODO
  end
  
  def test_update_failure
    # TODO
    lost_password = Factory :lost_password
    # update :update, :id => lost_password.token
  end
end