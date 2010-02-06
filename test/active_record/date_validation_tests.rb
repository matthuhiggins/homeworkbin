module ActiveRecord
  module DateValidationTests
    def self.included(test)
      test.extend ClassMethods
    end
    
    module ClassMethods
      def test_date_format_validation *attributes
        define_method :test_date_format_validation do
          attributes.each do |attribute|
            check_invalid_date_formats attribute
            check_valid_date_formats attribute
          end
        end
      end
    end
    
    private
      def check_invalid_date_formats(attribute)
        record = Factory.build self.class.factory_name

        ['', nil, '12/40/2004', '12/25', '10-2004'].each do |value|
          record[attribute] = value
          assert record.invalid?
          assert_equal 'must be mm/dd/yyyy', record.errors.on(attribute)
        end
      end

      def check_valid_date_formats(attribute)
        record = Factory.build self.class.factory_name

        ['jun 5 2003', '12/20/2004', '2/2/2003'].each do |value|
          record[attribute] = value
          assert record.valid?
        end
      end
  end
end