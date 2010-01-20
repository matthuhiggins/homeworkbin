module ActionController
  class StudentTestCase < TestCase
    def student_request(http_method, action, params = {}, options = {})
      process(action, params, {:person_id => current_student.id}, {}, http_method)
    end
    
    def student_get(action, params = {}, options = {})
      student_request('GET', action, params, options)
    end
  
    def student_post(action, params = {}, options = {})
      student_request('POST', action, params, options)
    end
  
    def student_put(action, params = {}, options = {})
      student_request('PUT', action, params, options)
    end
  
    def student_delete(action, params = {}, options = {})
      student_request('DELETE', action, params, options)
    end
  
    # def current_course
    #   @current_course ||= Factory(:course)
    # end
  
    def current_student
      @current_student ||= Factory(:student)
    end
  end
end