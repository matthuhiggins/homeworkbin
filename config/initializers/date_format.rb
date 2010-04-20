ActiveSupport.on_load :active_record do
  module ActiveRecord
    module ConnectionAdapters
      class Column
        class << self
          AMERICAN_DATE = /\A(\d{1,2})\/(\d{1,2})\/(\d{4})\z/
          
          def fallback_string_to_date(string)
            if string =~ AMERICAN_DATE
              new_date $3.to_i, $1.to_i, $2.to_i
            end
          end
        end
      end
    end
  end
end