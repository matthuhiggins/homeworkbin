require 'action_controller_test'

class Disciplines::TimeZoneTest < ActionController::TestCase
  class TestController < ActionController::Base
    include Disciplines::TimeZone

    def render_time_zone
      render text: Time.zone.name
    end

    def current_course
      @current_course ||= Factory.course.create time_zone: 'Quito'
    end
  end
  
  tests TestController

  test 'time_zone set from course' do
    with_generic_routes do
      get :render_time_zone
      assert_equal 'Quito', Time.zone.name
    end
  end
end