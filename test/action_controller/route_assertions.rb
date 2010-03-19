module ActionController
  module RouteAssertions
    extend ActiveSupport::Concern
    
    included do
      class_inheritable_array :expected_route_matches
    end
    
    module ClassMethods
      def test_route(expected_match, request)
        write_inheritable_hash :expected_route_matches, expected_match => request
        define_test_routes unless respond_to?(:test_routes)
      end
      
      def define_test_routes
        define_method :test_routes do
          self.class.read_inheritable_attribute(:expected_route_matches).each do |expected_match, request|
            assert_route_match expected_match, request
          end
        end
      end
    end
    
    def assert_route_match(expected_match, request)
      raise "Invalid expected_match of #{expected_match.inspect}" unless (expected_match =~ /(.*)#(.*)/)
      expected_options = {:controller => $1, :action => $2}
      
      raise "Invalid request of #{request.inspect}" unless (request =~ /(.*)#(.*)/)
      request_options = {:path => $1, :method => $2}
      
      assert_recognizes(expected_options, request_options)
    end
  end
end