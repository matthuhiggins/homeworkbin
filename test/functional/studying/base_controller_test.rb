require 'action_controller_test'

class Studying::BaseControllerTest < ActionController::StudyingTestCase
  class TestController < Studying::BaseController
    def index
      render text: 'foo'
    end
  end
  
  tests TestController
  
  test 'context' do
    with_generic_routes do
      studying_get :index

      assert_equal current_student, @controller.send(:current_student)
      assert_equal current_studier, @controller.send(:current_studier)
      assert_equal current_course, @controller.send(:current_course)
      assert_equal 'studying', @controller.sub_menu
    end
  end
end