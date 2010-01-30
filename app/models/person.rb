class Person < ActiveRecord::Base
  validates_presence_of :password, :if => :password_given?
  
  include Person::Remembered
  include Concerns::Authenticated
  include Concerns::EmailValidation
  
  has_many :lost_passwords
  
  
  def teaching?
    registered_as_teacher
  end
  
  def studying?
    Studier.exists? :student_id => self
  end
end