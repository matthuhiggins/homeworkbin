require 'active_record_test'

class Assignment::HandoutTest < ActiveSupport::TestCase
  def test_handout_on_create
    course = Factory :course
    Factory :studier, :course => course
    
    assert_emails 1 do
      Factory :assignment, :course => course, :handout => true
    end
  end
  
  def test_handout_on_update
    course = Factory :course
    Factory :studier, :course => course
    assignment = Factory :assignment, :course => course
    
    assert_emails 1 do
      assignment.update_attribute(:handout, true)
    end
  end
  
  def test_not_handouted
    course = Factory :course
    Factory :studier, :course => course
    
    assert_no_emails do
      Factory :assignment, :course => course, :handout => false
    end
  end
end