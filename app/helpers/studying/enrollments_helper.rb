module Studying
  module EnrollmentsHelper
    def enrollment_fields_partial(enrollment)
      enrollment.new_student? ? 'new_student' : 'existing_student'
    end
  end
end