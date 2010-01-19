require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert assigns(:registration).is_a?(Registration)
  end
  
  def test_create
    assert_emails 1 do
      post :create, :registration => {:email => 'foo@bar.com', :full_name => 'matty'}
    end
    assert_redirected_to :action => 'thanks'
  end
  
  def test_create_using_existing_email
    Factory :teacher, :email => 'foo@bar.com'
    post :create, :registration => {:email => 'foo@bar.com', :full_name => 'matty'}
    assert_template 'new'
  end
  
  def test_create_using_bad_email
    post :create, :registration => {:email => 'poopy', :full_name => 'matty'}
    assert_template 'new'
  end
  
  def test_show
    registration = Factory :registration
    get :show, :id => registration.token
    assert_equal registration, assigns(:registration)
    assert_not_nil assigns(:teacher)
  end
  
  def test_update
    registration = Factory :registration
    put :update,
        :id => registration.token,
        :teacher => {
          :email                  => 'foo@bar.com',
          :full_name              => 'matty',
          :password               => 'sekret',
          :password_confirmation  => 'sekret'
        }
    assert_redirected_to courses_path
    assert_raise(ActiveRecord::RecordNotFound) { registration.reload }
    assert !assigns(:teacher).new_record?
  end
  
  def test_update_fails_with_bad_token
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :id => 'poopy'
    end
  end
end