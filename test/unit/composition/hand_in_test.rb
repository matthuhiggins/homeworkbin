require 'active_record_test'

class Composition::HandInTest < ActiveSupport::TestCase
  def test_hand_in_on_create
    composition = Factory :composition, :hand_in => true

    assert composition.handed_in?
    assert_in_delta Time.current, composition.handed_in_at, 5
  end

  def test_hand_in_on_update
    composition = Factory :composition

    composition.update_attribute :hand_in, true

    assert composition.handed_in?
    assert_in_delta Time.current, composition.handed_in_at, 5
  end

  def test_not_handed_in
    composition = Factory :composition

    assert !composition.handed_in?
    assert_nil composition.handed_in_at
  end

  def test_late_before_hand_in
    assert !Factory.build(:composition, :assignment => Factory(:assignment_without_due, :due_at => Time.current + 65)).late_hand_in?
    assert Factory.build(:composition, :assignment => Factory(:assignment_without_due, :due_at => Time.current - 65)).late_hand_in?
  end

  def test_late_after_handed_in
    assignment = Factory :assignment, :due_date => Date.new(2005, 5, 10), :due_minutes => 180

    assert !Factory.build(:composition, :assignment => assignment, :handed_in_at => Time.zone.local(2005, 5, 10, 2)).late_hand_in?
    assert !Factory.build(:composition, :assignment => assignment, :handed_in_at => Time.zone.local(2005, 5, 10, 3)).late_hand_in?
    assert Factory.build(:composition, :assignment => assignment, :handed_in_at => Time.zone.local(2005, 5, 10, 4)).late_hand_in?
  end
end