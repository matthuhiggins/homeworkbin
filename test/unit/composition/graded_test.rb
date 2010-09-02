require 'active_record_test'

class Composition::GradedTest < ActiveRecord::TestCase
  def test_grade_scopes
    graded = factory.create graded_at: Time.current
    ungraded = factory.create graded_at: nil
    
    assert_equal [graded], Composition.graded
    assert_equal [ungraded], Composition.ungraded
  end
  
  def test_review_scopes
    ungraded = factory.create graded_at: nil
    grade_unreviewed = factory.create graded_at: Time.current, grade_reviewed_at: nil
    grade_reviewed = factory.create graded_at: Time.current, grade_reviewed_at: Time.current

    assert_equal [grade_unreviewed], Composition.grade_unreviewed
  end

  def test_graded?
    assert factory.build(graded_at: Time.current).graded?
    assert !factory.build(graded_at: nil).graded?
  end
end