require 'active_record_test'

class CompositionTest < ActiveRecord::TestCase
  include ActiveRecord::DenormalizationTests
  test_denormalization :studier, :student
  test_denormalization :assignment, :course
  
  def test_ungraded
    graded = Factory :composition, :graded => true
    ungraded = Factory :composition, :graded => false
    
    assert_equal [ungraded], Composition.ungraded
  end
end