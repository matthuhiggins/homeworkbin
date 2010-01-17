class Registration < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation

  validates_presence_of :full_name

  validate_on_create do |registration|
    if Teacher.exists? :email => registration.email
      registration.errors.add :email, 'is already in use'
    end
  end

  after_create do |registration|
    Mailer.deliver_registration registration
  end

  def build_teacher
    Teacher.new :email => email, :full_name => full_name
  end
end