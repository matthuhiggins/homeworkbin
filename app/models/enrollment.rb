class Enrollment < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation
  
  belongs_to :course
  delegate :teacher, :to => :course
  
  def student
    @student ||= Student.find_by_email(email)
  end
  
  def test_new_student?
    student.blank?
  end
  
  def build_student
    Student.new :email => email
  end
end