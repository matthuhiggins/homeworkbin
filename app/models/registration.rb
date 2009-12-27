class Registration < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation

  def create_person(attributes)
    person = nil
    transaction do 
      person = Person.create attributes.merge :email => email, :full_name => full_name
      delete_all :conditions => {:email => email}
    end
    person
  end
  
  after_create do |registration|
    Mailer.deliver_registration registration
  end
end