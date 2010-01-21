class Person < ActiveRecord::Base
  include Person::Authenticated
  include Person::Remembered
  include Concerns::EmailValidation
  
  def teacher?
    started_as_teacher
  end
  
  def student?
    courses_learned > 0
  end
end