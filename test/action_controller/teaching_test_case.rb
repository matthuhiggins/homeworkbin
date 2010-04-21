module ActionController
  class TeachingTestCase < PersonTestCase
    def teaching_request(http_method, action, params = {})
      person_request(http_method, action, params.reverse_merge(teaching_id: current_course.to_param))
    end
    request_methods :teaching
    
    def current_course
      @current_course ||= Factory.course.create teacher: current_teacher
    end
  
    def current_teacher
      current_person.teacher
    end
  end
end