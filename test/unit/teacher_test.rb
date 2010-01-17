require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  def test_courses_in_stock_default
    assert_equal 1, Factory(:teacher).courses_in_stock
  end
end