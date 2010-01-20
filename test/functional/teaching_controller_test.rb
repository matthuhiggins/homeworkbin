require 'test_helper'

class TeachingControllerTest < ActionController::TeacherTestCase
  def test_index
    teacher_get :index
    
    assert_not_nil assigns(:courses)
  end

  def show
    teacher_get :show, :id => current_course.id
    
    assert_kind_of Course, assigns(:course)
  end
  
  
end