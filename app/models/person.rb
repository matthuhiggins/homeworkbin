class Person < ActiveRecord::Base
  validates_presence_of :password, :if => :password_given?
  
  # validate do |person|
    # p "password = #{person.password}"
  # end

  include Person::Remembered
  include Concerns::Authenticated
  include Concerns::EmailValidation
  
  has_many :lost_passwords
  
  
  def teaching?
    registered_as_teacher
  end
  
  def studying?
    courses_studied > 0
  end
end