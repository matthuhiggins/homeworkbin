require 'active_support_test'

module ActiveRecord
  autoload :AuthenticatedTests, 'active_record/authenticated_tests'
  autoload :DateValidationTests, 'active_record/date_validation_tests'
  autoload :EmailValidationTests, 'active_record/email_validation_tests'
  autoload :PreviousTests, 'active_record/previous_tests'
  autoload :TokenizedTests, 'active_record/tokenized_tests'
end