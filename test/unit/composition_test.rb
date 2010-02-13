require 'active_record_test'

class CompositionTest < ActiveRecord::TestCase
  def test_ungraded
    graded = Factory :composition, :graded => true
    ungraded = Factory :composition, :graded => false
    
    assert_equal [ungraded], Composition.ungraded
  end
end