require 'action_controller_test'

class PeopleControllerTest < ActionController::PersonTestCase
  matches_resource 'settings'

  def text_show
    person_get :show

    assert_response :ok
  end
end