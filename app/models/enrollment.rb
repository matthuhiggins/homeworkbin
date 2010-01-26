class Enrollment < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation
  
  belongs_to :course
  delegate :teacher, :to => :course
  
  # validates_uniqueness_of :email, :scoped => :course_id
  
  validate_on_create do |enrollment|
    if enrollment.course.students.exists?(:email => enrollment.email)
      enrollment.errors.add :email, 'is already in this course'
    end
  end
  
  def student
    @student ||= Student.find_by_email(email)
  end
  
  def new_student?
    student.blank?
  end
  
  def build_student
    Student.new :email => email
  end
end