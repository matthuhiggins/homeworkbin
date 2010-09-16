module ActiveRecord
  module DateValidationTests
    extend ActiveSupport::Concern
    
    module ClassMethods
      def tests_date_format_validation *attributes
        attributes.each do |attribute|
          test "date_format_validation_for_#{attribute}" do
            check_invalid_date_formats attribute
            check_valid_date_formats attribute
          end
        end
      end
    end
    
    private
      ERROR_MESSAGE = 'must be mm/dd/yyyy'

      def check_invalid_date_formats(attribute)
        record = factory.build

        ['', nil, '12/40/2004', '12/25', '10-2004'].each do |value|
          record[attribute] = value
          assert record.invalid?
          assert record.errors[attribute].include?(ERROR_MESSAGE)
        end
      end

      def check_valid_date_formats(attribute)
        record = factory.build

        ['12/20/2004', '2/2/2003'].each do |value|
          record[attribute] = value
          record.valid?
          assert !record.errors[attribute].include?(ERROR_MESSAGE)
        end
      end
  end
end