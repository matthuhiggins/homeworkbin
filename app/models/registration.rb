class Registration < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation
  include Concerns::Authenticated

  validates_presence_of :full_name, :on => :create
  validates_presence_of :password, :on => :create

  validate_on_create do |registration|
    if Teacher.exists? :email => registration.email
      registration.errors.add :email, 'is already in use'
    end
  end

  after_create do |registration|
    Mailer.deliver_registration registration
  end

  def create_teacher!
    Registration.delete_all :email => email

    Teacher.create do |teacher|
      teacher.email               = email
      teacher.full_name           = full_name
      teacher.encrypted_password  = encrypted_password
      teacher.salt                = salt
    end
  end
end