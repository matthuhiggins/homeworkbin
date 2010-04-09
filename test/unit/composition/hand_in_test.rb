require 'active_record_test'

class Composition::HandInTest < ActiveRecord::TestCase
  def test_hand_in_on_create
    composition = factory.create :hand_in => true

    assert composition.handed_in?
    assert_in_delta Time.current, composition.handed_in_at, 5
  end

  def test_hand_in_on_update
    composition = factory.create

    composition.update_attribute :hand_in, true

    assert composition.handed_in?
    assert_in_delta Time.current, composition.handed_in_at, 5
  end

  def test_not_handed_in
    composition = factory.create

    assert !composition.handed_in?
    assert_nil composition.handed_in_at
  end

  def test_late_before_hand_in
    course = Factory.course.create :start_date => Date.current - 10, :end_date => Date.current + 10
    past_assignment = Factory.assignment_without_due.create :course => course, :due_at => Time.current - 65
    current_assignment = Factory.assignment_without_due.create :course => course, :due_at => Time.current + 65
    
    assert factory.build(:assignment => past_assignment).late_hand_in?
    assert !factory.build(:assignment => current_assignment).late_hand_in?
  end

  def test_late_after_handed_in
    course = Factory.course.create :start_date => Date.new(2005, 4, 10), :end_date => Date.new(2005, 6, 10)
    assignment = Factory.assignment.create :course => course, :due_date => Date.new(2005, 5, 10), :due_minutes => 180

    assert !factory.build(:assignment => assignment, :handed_in_at => Time.zone.local(2005, 5, 10, 2)).late_hand_in?
    assert !factory.build(:assignment => assignment, :handed_in_at => Time.zone.local(2005, 5, 10, 3)).late_hand_in?
    assert factory.build(:assignment => assignment, :handed_in_at => Time.zone.local(2005, 5, 10, 4)).late_hand_in?
  end
end