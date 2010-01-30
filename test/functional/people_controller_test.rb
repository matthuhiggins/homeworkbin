require 'action_controller_test'

class PeopleControllerTest < ActionController::PersonTestCase
  def text_show
    person_get :show
  end
end