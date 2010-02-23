class Person < ActiveRecord::Base
  validates_presence_of :password, :if => :password_given?
  validates_presence_of :full_name

  include Person::Remembered
  include ActiveRecord::Authenticated
  include ActiveRecord::EmailValidation
  include ActiveRecord::TimeZoneInfo

  has_many :lost_passwords

  before_create(:unless => :time_zone) do |person|
    person.time_zone = 'Pacific Time (US & Canada)'
  end
  
  def time_zone
    self[:time_zone] ||= 'Pacific Time (US & Canada)'
  end

  def teaching?
    registered_as_teacher
  end

  def studying?
    Studier.exists? :student_id => self
  end
end