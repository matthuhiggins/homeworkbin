class Assignment
  module Due
    extend ActiveSupport::Concern
    
    included do
      validates_inclusion_of :due_minutes, in: 0..1440
      
      extend ActiveRecord::DateValidation
      validates_date_format :due_date
      validate :validate_course_period_includes_due_date, if: lambda { |assignment| assignment.due_date.try(:acts_like?, :date) }
      
      delegate :past?, :today?, :future?, to: :due_date
      extend FinderMethods
    end

    module FinderMethods
      def past
        where(['due_date < ?', Date.current]).order('due_date desc, due_minutes desc')
      end
      
      def upcoming
        where(['due_date >= ?', Date.current]).order('due_date asc, due_minutes asc')
      end

      def previous
        past.first
      end

      def next
        upcoming.first
      end
    end
    
    def due_at
      Time.zone.local(
        due_date.year,
        due_date.month,
        due_date.day,
        due_minutes / 60,
        due_minutes % 60
      )
    end
    
    def due_at=(time)
      time = time.utc
      self.due_date = time.to_date
      self.due_minutes = time.hour * 60 + time.min
    end
    
    def late_submission?(submission)
      submission.handed_in_at > due_at
    end

    private
      def validate_course_period_includes_due_date
        if course.start_date > due_date
          errors.add :due_date, 'is before this course'
        elsif course.end_date < due_date
          errors.add :due_date, 'is after this course'
        end
      end
  end
end