require 'active_record_test'

class Composition::GradedTest < ActiveRecord::TestCase
  def test_scopes
    graded = factory.create graded_at: Time.current
    ungraded = factory.create graded_at: nil
    
    assert_equal [graded], Composition.graded
    assert_equal [ungraded], Composition.ungraded
  end

  def test_graded?
    assert factory.build(graded_at: Time.current).graded?
    assert !factory.build(graded_at: nil).graded?
  end
end