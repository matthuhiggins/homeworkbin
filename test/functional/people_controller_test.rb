require 'action_controller_test'

class PeopleControllerTest < ActionController::PersonTestCase
  matches_resource 'settings'

  def text_show
    person_get :show

    assert_response :ok
  end

  def test_update
    @request.env['HTTP_REFERER'] = 'foo'

    person_put :update, person: {full_name: 'Joe'}

    current_person.reload
    assert_equal 'Joe', current_person.full_name
    assert_redirected_to 'foo'
  end
end