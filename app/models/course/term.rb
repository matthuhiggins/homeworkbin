class Course
  module Term
    extend ActiveSupport::Concern

    included do
      extend FinderMethods
    end

    module FinderMethods
      def past
        where ['end_date < ?', Date.current]
      end
      
      def current
        where ['? between start_date and end_date', Date.current]
      end

      def upcoming
        where ['start_date > ?', Date.current]
      end
    end

    def date_range
      start_date..end_date
    end
  end
end