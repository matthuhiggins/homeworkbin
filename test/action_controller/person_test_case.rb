module ActionController
  class PersonTestCase < TestCase
    def person_request(http_method, action, params = {})
      process(action, params, {:person_id => current_person.to_param}, {}, http_method)
    end
    request_methods :person
    
    private
      def current_person
        @current_person ||= Factory :person
      end
  end
end