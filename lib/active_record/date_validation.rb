module ActiveRecord
  module DateValidation
    def validates_date_format *attributes
      validates_each *attributes do |record, attribute, value|
        begin
          !value.is_a?(Date) && Date.strptime(value, '%m/%d/%Y')
        rescue
          record.errors.add(attribute, 'must be mm/dd/yyyy')
        end
      end
    end
  end
end