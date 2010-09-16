require 'action_controller_test'

class Teaching::RegistrationsControllerTest < ActionController::TestCase
  include ActionMailer::TestHelper

  matches_resources 'signup'

  test 'index' do
    get :index

    assert assigns(:registration).is_a?(Registration)
  end
  
  test 'create' do
    assert_emails 1 do
      post(
        :create, 
        registration: {
          :email     => 'foo@bar.com', 
          full_name: 'matty',
          :password  => 'sekret'
        }
      )
    end

    assert_template 'thanks'
  end
  
  test 'create using blanks' do
    post(
      :create, 
      registration: {
        :email      => 'foo@bar.com',
        :full_name  => '',
        :password   => ''
      }
    )

    assert_template 'index'
  end
  
  test 'show' do
    registration = Factory.registration.create
    get :show, id: registration.token

    assert_equal registration, assigns(:registration)
    assert_destroyed registration
    assert !assigns(:teacher).new_record?
    assert_logged_in_as assigns(:teacher)
  end
  
  test 'show with bad token' do
    assert_raise ActiveRecord::RecordNotFound do
      get :show, id: 'poopy'
    end
  end
end