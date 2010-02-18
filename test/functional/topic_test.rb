require 'action_controller_test'

class HallMonitorTest < ActionController::TestCase
  class DefaultTopicController < ActionController::Base
    include Topic
  end
  
  class DefinedTopicController < ActionController::Base
    include Topic
    topic 'foo'
  end

  def test_default_topic
    assert_nil DefaultTopicController.new.topic
  end
  
  def test_defined_topic
    assert_equal 'foo', DefinedTopicController.new.topic
  end
end