require 'active_record_test'

class Assignment::HandoutTest < ActiveRecord::TestCase
  include ActionMailer::TestHelper

  test 'handout on create' do
    course = Factory.course.create
    Factory.studier.create course: course
    
    assert_emails 1 do
      assignment = factory.create course: course, handout: true
      assert_equal 1, assignment.handout_count
    end
  end

  test 'handout on update' do
    course = Factory.course.create
    Factory.studier.create course: course
    assignment = factory.create course: course
    
    assert_emails 1 do
      assignment.update_attribute(:handout, true)
      assert_equal 1, assignment.handout_count
    end
  end

  test 'not handed out' do
    course = Factory.course.create
    Factory.studier.create course: course
    
    assert_no_emails do
      assignment = factory.create course: course, handout: false
      assert_equal 0, assignment.handout_count
    end
  end
end