require 'action_controller_test'

class Disciplines::TimeZoneTest < ActionController::TestCase
  class TestController < ActionController::Base
    include Disciplines::TimeZone

    def render_time_zone
      render :text => Time.zone.name
    end

    def current_course
      @current_course ||= Factory(:course, :time_zone => 'Quito')
    end
  end
  
  def setup
    @controller = TestController.new
  end
  
  def test_time_zone_set_from_person
    get :render_time_zone
    assert_equal 'Quito', Time.zone.name
  end
end