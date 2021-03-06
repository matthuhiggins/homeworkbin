require 'active_support_test'

module ActiveRecord
  autoload :AuthenticatedTests, 'active_record/authenticated_tests'
  autoload :DateValidationTests, 'active_record/date_validation_tests'
  autoload :DenormalizationTests, 'active_record/denormalization_tests'
  autoload :EmailValidationTests, 'active_record/email_validation_tests'
  autoload :TokenizedTests, 'active_record/tokenized_tests'
end