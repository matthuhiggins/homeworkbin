module ActionView
  class TeachingTestCase < TestCase
    def current_course
      @current_course ||= Factory(:course)
    end
  end
end