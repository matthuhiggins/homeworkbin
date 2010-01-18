require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_invalid_credentials
    person = Factory :person

    post :create, :email => person.email, :password => 'wrong_sekret'

    assert_equal "Incorrect e-mail/password", flash[:notice]
    assert_equal person.email, flash[:email_attempt]
    assert_nil @controller.session[:person_id]
    assert_nil @response.cookies['last_email']
    assert_redirected_to(login_path)
  end
  
  def test_login
    person = Factory :person
    
    post :create, valid_credentials(person)
    
    assert_equal person.id, @controller.session[:person_id]
    assert_equal person.email, @response.cookies['last_email']
  end
  
  def test_login_with_remember_me
    person = Factory :person

    post :create, valid_credentials(person).update(:remember_me => "1")
    
    person.reload
    assert @response.cookies['remember_token'].present?
    assert_equal person.remember_token, @response.cookies['remember_token']
  end
  
  private
    def valid_credentials(person)
      {:email => person.email, :password => Factory.attributes_for(:person)[:password]}
    end
end