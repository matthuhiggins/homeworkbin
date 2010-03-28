require 'action_view_test'

class PeopleHelperTest < ActionView::TestCase
  def test_link_to_settings
    assert_dom_equal(
      link_to('Settings', teaching_person_path),
      link_to_settings
    )
  end
end