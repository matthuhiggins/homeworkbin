module ActionController
  module HallMonitorAssertions
    def assert_logged_in_as(person)
      assert_equal person.id, @controller.session[:person_id].to_i
    end
  end
end