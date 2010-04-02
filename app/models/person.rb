class Person < ActiveRecord::Base
  include Person::Remembered
  include ActiveRecord::Authenticated
  include ActiveRecord::EmailValidation

  validates_presence_of :password, :if => :password_given?
  validates_presence_of :full_name

  has_many :lost_passwords

  def teacher
    @teacher ||= becomes(Teacher)
  end

  def student
    @student ||= becomes(Student)
  end
end