class Person < ActiveRecord::Base
  include Person::Authenticated
  include Person::Remembered
  include Concerns::EmailValidation
  
  def teaching?
    registered_as_teacher
  end
  
  def studying?
    courses_studied > 0
  end
end