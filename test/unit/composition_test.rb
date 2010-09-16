require 'active_record_test'

class CompositionTest < ActiveRecord::TestCase
  include ActiveRecord::DenormalizationTests
  tests_denormalization :studier, :student
  tests_denormalization :assignment, :course
  
  test 'annotated saved as original' do
    composition = factory.create :original => 'foo'
    assert_equal 'foo', composition.annotated

    composition.update_attribute :annotated, 'bar'
    assert_equal 'bar', composition.annotated

    composition.update_attribute :original, 'faz'
    assert_equal 'faz', composition.annotated
  end
end