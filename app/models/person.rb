class Person < ActiveRecord::Base
  include Person::Authenticated
  include Person::Remembered
  include Concerns::EmailValidation
  
  def teacher?
    courses_taught > 0
  end
  
  def student?
    courses_learned > 0
  end
end