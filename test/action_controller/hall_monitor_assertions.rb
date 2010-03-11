module ActionController
  module HallMonitorAssertions
    def assert_logged_in_as(person)
      assert_equal person.id, @controller.session[:person_id].to_i
      assert_equal person.email, @response.cookies['last_login']
    end
    
    def assert_remembered_as(person)
      assert @response.cookies['remember_token'].present?
      assert_equal person.remember_token, @response.cookies['remember_token']
    end
  end
end