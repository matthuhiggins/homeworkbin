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
  
  after_save do |enrollment|
    if enrollment.student.try :automatically_enroll
      enrollment.enroll_student!
    end
  end
  
  def student
    @student ||= (Student.find_by_email(email) || Student.new(:email => email))
  end
  
  def student=(attributes)
    @student = Student.new attributes
  end
  
  def new_student?
    student.new_record?
  end
  
  def enroll_student!
    if student.valid?
      course.students << student
      destroy
    end
  end
end