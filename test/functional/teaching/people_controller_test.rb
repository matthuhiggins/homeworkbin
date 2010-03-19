require 'action_controller_test'

class Teaching::PeopleControllerTest < ActionController::PersonTestCase
  test_resource 'teaching/settings'

  def text_show
    person_get :show

    assert_response :ok
  end
end