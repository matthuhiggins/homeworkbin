class Registration < ActiveRecord::Base
  include ActiveRecord::Tokenized
  include ActiveRecord::EmailValidation
  include ActiveRecord::Authenticated

  validates_presence_of :full_name, :on => :create
  validates_presence_of :password, :on => :create

  validate :email, :on => :create do
    if Teacher.exists? :email => email
      errors.add :email, 'is already in use'
    end
  end

  after_create do
    Mailer.registration(self).deliver
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