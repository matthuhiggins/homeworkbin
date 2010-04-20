class LostPassword < ActiveRecord::Base
  include ActiveRecord::Tokenized

  belongs_to :person

  attr_reader :email
  def email=(value)
    raise "Trying to set email while updating lost password record" unless new_record?
    @email = value
    self.person = Person.find_by_email value
  end
  
  validate :email, on: :create do
    if person.blank?
      errors.add :email, 'does not exist'
    end
  end

  after_create do |lost_password|
    Mailer.lost_password(lost_password).deliver
  end
  
  attr_reader :new_password
  def new_password=(password)
    raise "Trying to set password while creating lost password record" if new_record?
    @new_password = password
  end
  
  validates_presence_of :new_password, on: :update
  after_update do |lost_password|
    lost_password.person.update_attribute :password, lost_password.new_password
    lost_password.destroy
  end
end