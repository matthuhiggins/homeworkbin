class LostPassword < ActiveRecord::Base
  include Concerns::Tokenized
  include Concerns::EmailValidation

  belongs_to :person

  attr_reader :email
  def email=(value)
    @email = value
    self.person = Person.find_by_email value
  end
  
  validate_on_create do |lost_password|
    if lost_password.person.blank?
      errors.add :email, 'does not exist'
    end
  end

  after_create do |lost_password|
    Mailer.deliver_lost_password lost_password
  end
end