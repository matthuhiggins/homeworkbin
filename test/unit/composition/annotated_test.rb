require 'active_record_test'

class Composition::AnnotationTest < ActiveRecord::TestCase
  test 'has_many annotations' do
    composition = factory.create
    Factory.annotation.create :composition => composition
    Factory.annotation.create :composition => composition

    assert_equal 2, composition.annotations.count

    new_annotation = Annotation.new(
      :identifier => 1,
      :snippet    => 'and therefore, Freud was a pervert',
      :comment    => 'gold star!'
    )
    composition.update_attribute :annotations, [new_annotation]
    
    assert_equal 1, composition.annotations.count
    assert new_annotation.persisted?
  end

  test 'annotations attributes' do
    composition = factory.create
    happy_annotation = {
      :identifier => 1,
      :snippet    => 'and therefore, Freud was a pervert',
      :comment    => 'gold star!'
    }
    mean_annotation = {
      :identifier => 2,
      :snippet    => 'rendor da parshal',
      :comment    => 'terrible spelling'
    }

    composition.update_attribute :annotations_attributes, [happy_annotation, mean_annotation]

    assert_equal 2, composition.annotations.count
    assert_equal 1, composition.annotations.first.identifier
    assert_equal 2, composition.annotations.second.identifier
  end
end