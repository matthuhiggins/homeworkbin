require 'action_controller_test'

class Teaching::BaseControllerTest < ActionController::TeachingTestCase
  class TestController < Teaching::BaseController
    def index
      render text: 'foo'
    end
  end

  tests TestController
  
  test 'context' do
    with_generic_routes do
      teaching_get :index

      assert_equal current_teacher, @controller.send(:current_teacher)
      assert_equal current_course, @controller.send(:current_course)
      assert @controller.send(:teaching?)
    end
  end
end