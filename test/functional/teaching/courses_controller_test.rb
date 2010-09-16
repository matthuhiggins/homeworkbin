require 'action_controller_test'

class Teaching::CoursesControllerTest < ActionController::TeachingTestCase
  matches_resources 'teaching'

  test 'index' do
    teaching_get :index
    
    assert_not_nil assigns(:courses)
  end

  test 'show' do
    teaching_get :show, id: current_course.to_param

    assert_response :ok
  end
  
  test 'new' do
    teaching_get :new
    assert_response :ok
  end
  
  test 'create' do
    teaching_post :create, course: {
      :name         => 'ENV 101',
      :start_date   => '5/6/2010',
      :end_date     => '8/1/2010'
    }
    
    assert !assigns(:course).new_record?
    assert_redirected_to teaching_path(assigns(:course))
  end
  
  test 'failed_create' do
    teaching_post :create, course: {
      :name         => '',
      :start_date   => '5/6/2010',
      :end_date     => '8/1/2010'
    }
    
    assert_template 'new'
  end
  
  test 'edit' do
    teaching_get :edit, id: current_course.to_param
    
    assert_equal current_course, assigns(:course)
  end

  test 'update' do
    teaching_put :update, {
      id: current_course.to_param,
      course: {name: 'foo bar'}
    }
    
    current_course.reload
    assert_equal 'foo bar', current_course.name
  end
end