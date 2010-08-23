module ActiveRecord
  module DateValidation
    def validates_date_format *attributes
      validates_each *attributes do |record, attribute, value|
        if value.nil?
          record.errors.add(attribute, 'must be mm/dd/yyyy')
        elsif !value.acts_like?(:date)
          record.errors.add(attribute, 'must be a Date')
        end
      end
    end
  end
end
