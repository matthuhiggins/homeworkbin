module ActionController
  class StudentTestCase < TestCase
    def student_request(http_method, action, params = {}, options = {})
      process(action, params.reverse_merge(:studying_id => current_course.id), {:person_id => current_student.id}, {}, http_method)
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
  
    def current_course
      build_studier!
      @current_course
    end

    def current_student
      build_studier!
      @current_student
    end
    
    def current_studier
      build_studier!
      @current_studier
    end
    
    private
      def build_studier!
        @current_course ||= Factory(:course)
        @current_student ||= Factory(:student)
        @current_studier ||= Factory(:studier, :course => @current_course, :student => @current_student)
      end
  end
end