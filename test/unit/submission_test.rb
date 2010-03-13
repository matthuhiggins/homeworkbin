require 'active_record_test'

class SubmissionTest < ActiveRecord::TestCase
  def test_default_scope
    not_turned_in = Factory :composition, :hand_in => false
    turned_in = Factory :composition, :hand_in => true
    
    assert_equal [turned_in.becomes(Submission)], Submission.all
  end
end