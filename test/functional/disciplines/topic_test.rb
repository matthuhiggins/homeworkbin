require 'action_controller_test'

class Disciplines::TopicTest < ActionController::TestCase
  class DefaultTopicController < ActionController::Base
    include Disciplines::Topic
  end

  class SubMenuController < ActionController::Base
    include Disciplines::Topic
    shows_sub_menu 'bar'
  end

  class DefinedTopicController < ActionController::Base
    include Disciplines::Topic
    shows_topic 'foo'
  end

  test 'empty undefined attributes' do
    DefaultTopicController.new.tap do |controller|
      assert_nil controller.topic
      assert !controller.show_sub_menu?
    end
  end

  test 'defined sub menu' do
    SubMenuController.new.tap do |controller|
      assert controller.show_sub_menu?
      assert_equal 'sub_menus/bar', controller.sub_menu_partial
    end
  end
  
  test 'defined topic' do
    assert_equal 'foo', DefinedTopicController.new.topic
  end
end