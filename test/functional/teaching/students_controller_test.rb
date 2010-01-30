require 'action_controller_test'

class Teaching::StudentsControllerTest < ActionController::TeachingTestCase
  def test_index
    teaching_get :index
    assert_not_nil assigns(:students)
  end
  
  def test_show
    student = Factory :student
    current_course.students << student
    
    teaching_get :show, :id => student.to_param
    
    assert_equal student, assigns(:student)
  end
  
  def test_destroy
    student = Factory :student
    current_course.students << student

    teaching_delete :destroy, :id => student.to_param

    assert_raise ActiveRecord::RecordNotFound do
      student.reload
    end
  end
end