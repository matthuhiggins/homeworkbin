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
end