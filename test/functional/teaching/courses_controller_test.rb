require 'test_helper'

class Teaching::CoursesControllerTest < ActionController::TeacherTestCase
  def test_index
    teacher_get :index
    
    assert_not_nil assigns(:courses)
  end

  def test_show
    teacher_get :show, :id => current_course.id
    
    assert_kind_of Course, assigns(:course)
  end
  
  def test_new
    teacher_get :new
    assert_response :ok
  end
  
  def test_create
    teacher_post :create, :course => {
      :name         => 'ENV 101',
      :description  => 'ez cheese',
      :start        => '5/6/2010',
      :end          => '8/1/2010'
    }
    
    assert !assigns(:course).new_record?
    assert_redirected_to teaching_path(assigns(:course))
  end
  
  def test_failed_create
    teacher_post :create, :course => {
      :name         => '',
      :description  => '',
      :start        => '5/6/2010',
      :end          => '8/1/2010'
    }
    
    assert_template 'new'
  end
end