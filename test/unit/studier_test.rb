require 'active_record_test'

class StudierTest < ActiveRecord::TestCase
  def test_delegation
    studier = Factory :studier

    assert_equal studier.course.teacher, studier.teacher
    assert_equal studier.student.full_name, studier.full_name
    assert_equal studier.student.email, studier.email
  end
  
  def test_submission_for
    studier = Factory :studier
    due_assignment = Factory :assignment, :course => studier.course
    submission = Factory :submission, :assignment => due_assignment, :studier => studier
    pending_assignment = Factory :assignment, :course => studier.course
    
    assert_equal submission, studier.submission_for(due_assignment)
    assert_nil studier.submission_for(pending_assignment)
  end
end