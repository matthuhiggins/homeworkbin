require 'active_record_test'

class StudierTest < ActiveRecord::TestCase
  test 'delegation' do
    studier = factory.create

    assert_equal studier.course.teacher, studier.teacher
    assert_equal studier.student.full_name, studier.full_name
    assert_equal studier.student.email, studier.email
  end
  
  test 'submission_for' do
    studier = factory.create
    due_assignment = Factory.assignment.create course: studier.course
    submission = Factory.submission.create assignment: due_assignment, studier: studier
    pending_assignment = Factory.assignment.create course: studier.course
    
    assert_equal submission, studier.submission_for(due_assignment)
    assert_nil studier.submission_for(pending_assignment)
  end
end