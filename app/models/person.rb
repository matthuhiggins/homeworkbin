class Person < ActiveRecord::Base
  validates_presence_of :password, :if => :password_given?
  validates_presence_of :full_name
  
  include Person::Remembered
  include ActiveRecord::Authenticated
  include ActiveRecord::EmailValidation
  
  has_many :lost_passwords
  
  
  def teaching?
    registered_as_teacher
  end
  
  def studying?
    Studier.exists? :student_id => self
  end
end