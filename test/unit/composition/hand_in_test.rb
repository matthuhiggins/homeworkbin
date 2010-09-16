require 'active_record_test'

class Composition::HandInTest < ActiveRecord::TestCase
  test 'handed_in_scope' do
    not_handed_in = Factory.composition.create hand_in: false
    handed_in = Factory.composition.create hand_in: true

    assert_equal [handed_in], Composition.handed_in.all
  end

  test 'hand_in_on_create' do
    composition = factory.create hand_in: true

    assert composition.handed_in?
    assert_in_delta Time.current, composition.handed_in_at, 5
  end
  
  test 'hand_in!' do
    composition = factory.create

    composition.hand_in!

    assert composition.handed_in?
    assert_in_delta Time.current, composition.handed_in_at, 5
  end

  test 'not handed in' do
    composition = factory.create

    assert !composition.handed_in?
    assert_nil composition.handed_in_at
  end

  test 'late before hand in' do
    course = Factory.course.create start_date: Date.current - 10, end_date: Date.current + 10
    past_assignment = Factory.assignment.create course: course, due_at: Time.current - 65
    current_assignment = Factory.assignment.create course: course, due_at: Time.current + 65
    
    assert factory.build(assignment: past_assignment).late_hand_in?
    assert !factory.build(assignment: current_assignment).late_hand_in?
  end

  test 'late after handed in' do
    course = Factory.course.create start_date: Date.new(2005, 4, 10), end_date: Date.new(2005, 6, 10)
    assignment = Factory.assignment.create course: course, due_date: Date.new(2005, 5, 10), due_minutes: 180

    assert !factory.build(assignment: assignment, handed_in_at: Time.zone.local(2005, 5, 10, 2)).late_hand_in?
    assert !factory.build(assignment: assignment, handed_in_at: Time.zone.local(2005, 5, 10, 3)).late_hand_in?
    assert factory.build(assignment: assignment, handed_in_at: Time.zone.local(2005, 5, 10, 4)).late_hand_in?
  end
end