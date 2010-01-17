class Enrollment < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation
  extend Concerns::Denormalization

  belongs_to :course, :denormalize => :teacher
  
  def student
    Student.find_by_email email
  end
  
  def build_student
    Student.new :email => email
  end
  
  after_create do |enrollment|
    Mailer.deliver_enrollment enrollment
  end
end