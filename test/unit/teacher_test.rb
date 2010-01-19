require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  def test_courses_available_default
    assert_equal 1, Factory(:teacher).courses_available
  end
end