require 'active_support_test'

module ActiveRecord
  autoload :EmailValidationTests, 'active_record/email_validation_tests'
  autoload :TokenizedTests, 'active_record/tokenized_tests'
  autoload :AuthenticatedTests, 'active_record/authenticated_tests'
end