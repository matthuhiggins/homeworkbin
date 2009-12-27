class Invitation < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation

  belongs_to :course
  belongs_to :teacher
  
  def existing_person
    Person.find_by_email email
  end
  
  after_create do |invitation|
    Mailer.deliver_invitation invitation
  end
end