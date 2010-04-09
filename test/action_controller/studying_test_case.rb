module ActionController
  class StudyingTestCase < PersonTestCase
    def studying_request(http_method, action, params = {})
      person_request(http_method, action, params.reverse_merge(:studying_id => current_course.id))
    end
    request_methods :studying

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
        @current_course ||= Factory.course.create
        @current_student ||= current_person.student
        @current_studier ||= Factory.studier.create :course => @current_course, :student => @current_student
      end
  end
end