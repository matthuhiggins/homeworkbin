module ActionController
  class TeacherTestCase < TestCase
    def teacher_request(http_method, action, params = {}, options = {})
      process(action, params, {:person_id => current_teacher.id}, {}, http_method)
    end
    
    def teacher_get(action, params = {}, options = {})
      teacher_request('GET', action, params, options)
    end
  
    def teacher_post(action, params = {}, options = {})
      teacher_request('POST', action, params, options)
    end
  
    def teacher_put(action, params = {}, options = {})
      teacher_request('PUT', action, params, options)
    end
  
    def teacher_delete(action, params = {}, options = {})
      teacher_request('DELETE', action, params, options)
    end
  
    def current_course
      @current_course ||= Factory(:course)
    end
  
    def current_teacher
      current_course.teacher
    end
  end
end