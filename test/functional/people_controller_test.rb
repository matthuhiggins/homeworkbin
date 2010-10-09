require 'action_controller_test'

class PeopleControllerTest < ActionController::PersonTestCase
  matches_resource 'settings'

  test 'show' do
    person_get :show

    assert_response :ok
  end

  test 'update' do
    person_put :update, person: {full_name: 'Joe'}

    current_person.reload
    assert_equal 'Joe', current_person.full_name
    assert_redirected_to settings_path
  end

  test 'get password' do
    person_get :password
    assert_response :ok
  end

  test 'put password' do
    person_put :password, person: {password: 'baz'}

    assert_redirected_to settings_path
  end
end