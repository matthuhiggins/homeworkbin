class Assignment
  module Handout
    def self.included base
      base.class_eval do
        attr_accessor :handout
        base.after_save :handout_assignment, :if => :handout
      end
    end
    
    private
      def handout_assignment
        course.students.each do |student|
          Mailer.deliver_assignment self, student
        end
      end
  end
end
