class Assignment
  module Due
    def self.included base
      base.class_eval do
        validates_inclusion_of :due_minutes, :in => 0..1440
        
        extend ActiveRecord::DateValidation
        validates_date_format :due_date
      end
    end

    def due_at
      Time.mktime(
        due_date.year,
        due_date.month,
        due_date.day,
        due_minutes / 60,
        due_minutes % 60
      )
    end
  end
end