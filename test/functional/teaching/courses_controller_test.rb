require 'action_controller_test'

class Teaching::CoursesControllerTest < ActionController::TeachingTestCase
  def test_index
    teaching_get :index
    
    assert_not_nil assigns(:courses)
  end

  def test_show
    teaching_get :show, :id => current_course.id
    
    assert_kind_of Course, assigns(:course)
  end
  
  def test_new
    teaching_get :new
    assert_response :ok
  end
  
  def test_create
    teaching_post :create, :course => {
      :name         => 'ENV 101',
      :description  => 'ez cheese',
      :start_date   => '5/6/2010',
      :end_date     => '8/1/2010'
    }
    
    assert !assigns(:course).new_record?
    assert_redirected_to teaching_path(assigns(:course))
  end
  
  def test_failed_create
    teaching_post :create, :course => {
      :name         => '',
      :description  => '',
      :start_date   => '5/6/2010',
      :end_date     => '8/1/2010'
    }
    
    assert_template 'new'
  end
end