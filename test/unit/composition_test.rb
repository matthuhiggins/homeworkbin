require 'active_record_test'

class CompositionTest < ActiveRecord::TestCase
  include ActiveRecord::DenormalizationTests
  test_denormalization :studier, :student
  test_denormalization :assignment, :course
  
  def test_grade_scopes
    graded = factory.create graded_at: Time.current
    ungraded = factory.create graded_at: nil
    
    assert_equal [ungraded], Composition.ungraded
  end

  def test_annotated_saved_as_original
    composition = factory.create :original => 'foo'
    assert_equal 'foo', composition.annotated

    composition.update_attribute :annotated, 'bar'
    assert_equal 'bar', composition.annotated

    composition.update_attribute :original, 'faz'
    assert_equal 'faz', composition.annotated
  end
end