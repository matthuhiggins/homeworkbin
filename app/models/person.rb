class Person < ActiveRecord::Base
  include Person::Authenticated
  include Person::Remembered
  include Concerns::EmailValidation

  has_many :courses
end