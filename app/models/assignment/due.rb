class Assignment
  module Due
    def self.included base
      base.class_eval do
        # attr_accessor :due_minutes
        validates_inclusion_of :due_minutes, :in => 0..1440
        
        extend ActiveRecord::DateValidation
        validates_date_format :due_date
      end
    end
    
    private
      # def store_due_at
      #   self.due_at = Time.mktime(
      #     converted_due_date.year,
      #     converted_due_date.month,
      #     converted_due_date.day,
      #     due_minutes / 60,
      #     due_minutes % 60
      #   )
      # end
      
      def converted_due_minutes
        
      end
      
      def converted_due_date
        @converted_due_date ||= due_date.is_a?(Date) ? due_date : Date.strptime(due_date, '%m/%d/%Y')
      end
  end
end