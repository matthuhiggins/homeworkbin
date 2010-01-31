class Enrollment < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation
  
  belongs_to :course
  delegate :teacher, :to => :course

  validate_on_create do |enrollment|
    if enrollment.course.students.exists?(:email => enrollment.email)
      enrollment.errors.add :email, 'is already in this course'
    end
  end
  
  attr_accessor :student_attributes_submitted

  validate_on_update :if => :student_attributes_submitted do |enrollment|
    if enrollment.student.invalid?
      enrollment.errors.add :student, 'is invalid'
    end
  end
  
  after_save :enroll_student!, :if => :perform_enrollment?
  
  def student
    @student ||= (Student.find_by_email(email) || Student.new(:email => email))
  end
  
  def student=(attributes)
    self.student_attributes_submitted = true
    @student = Student.new attributes
  end
  
  def new_student?
    student.new_record?
  end

  def perform_enrollment?
    student.valid? && student.automatically_enroll
  end

  def enroll_student!
    if student.valid?
      course.students << student
      destroy
    end
  end
end