module ActionController
  module RouteAssertions
    extend ActiveSupport::Concern
    
    included do
      class_attribute :expected_route_matches
    end
    
    module ClassMethods
      def matches_route(expected_match, request)
        unless respond_to?(:test_matches)
          self.expected_route_matches = {}
          define_test_matches
        end

        expected_route_matches[expected_match] = request
      end

      def matches_resources(path)
        matches_route 'new',     "#{path}/new#get"
        matches_route 'create',  "#{path}#post"
        matches_route 'index',   "#{path}#get"
        matches_route 'show',    "#{path}/:id#get"
        matches_route 'edit',    "#{path}/:id/edit#get"
        matches_route 'update',  "#{path}/:id#put"
      end
      
      def matches_resource(path)
        matches_route 'new',     "#{path}/new#get"
        matches_route 'create',  "#{path}#post"
        matches_route 'update',  "#{path}#put"
        matches_route 'show',    "#{path}#get"
      end
      
      def define_test_matches
        define_method :test_matches do
          self.class.expected_route_matches.each do |expected_match, request|
            assert_route_match expected_match, request
          end
        end
      end
    end
    
    def assert_route_match(expected_action, request)
      if (request =~ /(.*)#(.*)/)
        path = $1
        method = $2
        params = {}
        path.gsub!(/:([a-z]\w*)/) do |param|
          value = params.size.to_s
          params[$1] = value
          value
        end

        request_options = {path: path, method: method}
      else
        raise "Invalid request of #{request.inspect}" 
      end

      params.merge!(
        controller: @controller.class.name.underscore.gsub(/_controller/, ''),
        action:     expected_action
      )
      
      assert_recognizes(params, request_options)
    end
  end
end