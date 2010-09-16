require 'action_controller_test'

class Disciplines::HallMonitorTest < ActionController::TestCase
  class DefaultTopicController < ActionController::Base
    include Disciplines::Topic
  end
  
  class DefinedTopicController < ActionController::Base
    include Disciplines::Topic
    topic 'foo'
  end

  test 'default topic' do
    assert_nil DefaultTopicController.new.topic
  end
  
  test 'defined topic' do
    assert_equal 'foo', DefinedTopicController.new.topic
  end
end