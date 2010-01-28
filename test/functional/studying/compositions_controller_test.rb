require 'test_helper'

class Studying::CompositionsControllerTest < ActionController::StudentTestCase
  def test_new
    student_get :new, :assignment_id => assignment.to_param
    assert_kind_of Composition, assigns(:composition)
  end
  
  def test_create
    student_post :create, {
      :assignment_id => assignment.to_param,
      :composition => {:paper => "The quick brown fox jumped over the lazy dog"}
    }
    
    assert !assigns(:composition).new_record?
  end
  
  def test_show
    composition = Factory :composition, :assignment => assignment, :studier => current_studier
    
    student_get :show, :id => @composition.to_param
    
    assert_equal composition, assigns(:composition)
  end
  
  private
    def assignment
      @assignment ||= Factory(:assignment, :course => current_course)
    end
end