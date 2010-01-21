require 'test_helper'

class Studying::CoursesControllerTest < ActionController::StudentTestCase
  def test_index
    student_get :index
    
    assert_not_nil assigns(:courses)
  end

  def show
    # student_get :show, :id => current_course.id
    
    # assert_kind_of Course, assigns(:course)
  end
end