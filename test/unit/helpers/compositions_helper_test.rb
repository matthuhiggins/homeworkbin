require 'action_view_test'

class CompositionsHelperTest < ActionView::TestCase
  def test_handed_in_at
    assert_equal(
      'today at 3:20am',
      composition_handed_in_at(Factory.composition.build handed_in_at: Time.current.change(hour: 3, min: 20))
    )

    assert_equal(
      'yesterday at 3:20am',
      composition_handed_in_at(Factory.composition.build handed_in_at: Time.current.yesterday.change(hour: 3, min: 20))
    )

    assert_equal(
      'Sun, Dec 25 at 1:15pm',
      composition_handed_in_at(Factory.composition.build handed_in_at: Time.utc(2005, 12, 25, 13, 15))
    )
  end
  
  def test_preview
    assert_equal(
      'hello worldL',
      composition_preview(Factory.composition.build(original: 'hello<br>world<span>Lol</span>'), 12)
    )
  end
end