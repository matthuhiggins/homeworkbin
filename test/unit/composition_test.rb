require 'active_record_test'

class CompositionTest < ActiveRecord::TestCase
  include ActiveRecord::DenormalizationTests
  test_denormalization :studier, :student
  test_denormalization :assignment, :course
  
  def test_ungraded
    graded = factory.create graded_at: Time.current
    ungraded = factory.create graded_at: nil
    
    assert_equal [ungraded], Composition.ungraded
  end
end