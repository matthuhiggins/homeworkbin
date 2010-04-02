class Assignment
  module Handout
    extend ActiveSupport::Concern

    included do
      attr_accessor :handout
      after_save :handout_assignment, :if => :handout
    end
    
    private
      def handout_assignment
        increment :handout_count
        course.students.each do |student|
          Mailer.assignment(self, student).deliver
        end
      end
  end
end
