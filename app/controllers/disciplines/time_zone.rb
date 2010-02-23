module Disciplines
  module TimeZone
    def self.included(controller)
      controller.before_filter :set_time_zone, :if => :current_person
    end

    private
      def set_time_zone
        Time.zone = current_person.time_zone
      end
  end
end