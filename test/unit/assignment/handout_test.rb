require 'active_record_test'

class Assignment::HandoutTest < ActiveRecord::TestCase
  include ActionMailer::TestHelper

  def test_handout_on_create
    course = Factory.course.create
    Factory.studier.create course: course
    
    assert_emails 1 do
      assignment = factory.create course: course, handout: true
      assert_equal 1, assignment.handout_count
    end
  end

  def test_handout_on_update
    course = Factory.course.create
    Factory.studier.create course: course
    assignment = factory.create course: course
    
    assert_emails 1 do
      assignment.update_attribute(:handout, true)
      assert_equal 1, assignment.handout_count
    end
  end

  def test_not_handouted
    course = Factory.course.create
    Factory.studier.create course: course
    
    assert_no_emails do
      assignment = factory.create course: course, handout: false
      assert_equal 0, assignment.handout_count
    end
  end
end