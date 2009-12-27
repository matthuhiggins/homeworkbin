class Person < ActiveRecord::Base
  include Person::Authenticated
  include Concerns::EmailValidation

  has_many :courses
end