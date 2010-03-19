module ActionController
  module RouteAssertions
    extend ActiveSupport::Concern
    
    included do
      class_inheritable_array :expected_route_matches
    end
    
    module ClassMethods
      def test_match(expected_match, request)
        write_inheritable_hash :expected_route_matches, expected_match => request
        define_test_matchs unless respond_to?(:test_matchs)
      end

      def test_resources(path)
        test_match 'new',     "#{path}/new#get"
        test_match 'create',  "#{path}#post"
        test_match 'index',   "#{path}#get"
        test_match 'show',    "#{path}/:id#get"
        test_match 'edit',    "#{path}/:id/edit#get"
        test_match 'update',  "#{path}/:id#put"
      end
      
      def test_resource(path)
        test_match 'new',     "#{path}/new#get"
        test_match 'create',  "#{path}#post"
        test_match 'update',  "#{path}#put"
        test_match 'show',    "#{path}#get"
      end
      
      def define_test_matchs
        define_method :test_matches do
          self.class.read_inheritable_attribute(:expected_route_matches).each do |expected_match, request|
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

        request_options = {:path => path, :method => method}
      else
        raise "Invalid request of #{request.inspect}" 
      end

      params.merge!(
        :controller => @controller.class.name.underscore.gsub(/_controller/, ''),
        :action     => expected_action
      )
      
      assert_recognizes(params, request_options)
    end
  end
end