require 'action_controller_test'

class Teaching::RegistrationsControllerTest < ActionController::TestCase
  def test_new
    get :new

    assert assigns(:registration).is_a?(Registration)
  end
  
  def test_create
    assert_emails 1 do
      post(
        :create, 
        :registration => {
          :email     => 'foo@bar.com', 
          :full_name => 'matty',
          :password  => 'sekret'
        }
      )
    end

    assert_redirected_to :action => 'thanks'
  end
  
  def test_create_using_blanks
    post(
      :create, 
      :registration => {
        :email      => 'foo@bar.com',
        :full_name  => '',
        :password   => ''
      }
    )

    assert_template 'new'
  end
  
  def test_show
    registration = Factory :registration
    get :show, :id => registration.token

    assert_equal registration, assigns(:registration)
    assert_raise(ActiveRecord::RecordNotFound) { registration.reload }
    assert !assigns(:teacher).new_record?
    assert_logged_in_as assigns(:teacher)
  end
  
  def test_show_with_bad_token
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :id => 'poopy'
    end
  end
end