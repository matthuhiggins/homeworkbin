module Disciplines
  module TimeZone
    def self.included(controller)
      controller.before_filter :set_time_zone, :if => :current_course
    end

    private
      def set_time_zone
        Time.zone = current_course.time_zone
      end
  end
end