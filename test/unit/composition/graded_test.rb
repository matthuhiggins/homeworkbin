require 'active_record_test'

class Composition::GradedTest < ActiveRecord::TestCase
  def test_grade_scopes
    graded = factory.create graded_at: Time.current
    ungraded = factory.create graded_at: nil
    
    assert_equal [ungraded], Composition.ungraded
  end
end