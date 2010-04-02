class Enrollment < ActiveRecord::Base
  include ActiveRecord::Tokenized
  include ActiveRecord::EmailValidation
  
  belongs_to :course
  delegate :teacher, :to => :course

  before_validation :on => :create do
    if course.students.exists?(:email => email)
      errors.add :email, 'is already in this course'
    end
  end
  
  attr_accessor :student_attributes_submitted
  attr_accessor :accept_enrollment

  validate_on_update :if => :student_attributes_submitted do
    if student.invalid?
      errors.add :student, 'is invalid'
    end
  end
  
  after_create do
    if student.automatically_enroll
      studier = enroll_student!
      Mailer.deliver_studier studier
    else
      Mailer.deliver_enrollment self
    end
  end

  after_update :enroll_student!, :if => :accept_enrollment
  
  def student
    @student ||= (Student.find_by_email(email) || Student.new(:email => email))
  end
  
  def student=(attributes)
    self.student_attributes_submitted = true
    student.attributes = attributes
  end
  
  def new_student?
    student.new_record?
  end
  
  def enroll_student!
    if student.valid?
      studier = course.studiers.create :student => student
      destroy
      studier
    end
  end
end