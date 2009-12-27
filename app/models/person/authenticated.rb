require 'digest/sha1'

module Person::Authenticated
  def self.included(person)
    person.class_eval do
      has_many :lost_passwords

      before_save :encrypt_password

      attr_accessor :password, :lost_password_token
      attr_protected :encrypted_password, :salt

      validates_confirmation_of :password
      validates_presence_of     :password, :on => :create
      validates_presence_of     :password, :on => :update, :unless => Proc.new { |person| person.password.nil? }
      validate_on_update        :validate_password_update, :unless => Proc.new { |person| person.password.nil? }

      extend ClassMethods
    end
  end

  module ClassMethods
    def authenticate(email, password)
      if person = find_by_email(email) && person.authenticate(password)
        person
      end
    end
    
    def encrypt_password(password, salt)
      string_to_hash = password + "tarde" + salt
      Digest::SHA1.hexdigest(string_to_hash)
    end
  end

  def authenticate(pwd)
    return false unless pwd.is_a?(String)
    self.encrypted_password == self.class.encrypted_password(pwd, self.salt)
  end

  private
    def encrypt_password
      return if password.nil?
      self.salt = ActiveSupport::SecureRandom.base64(16)
      self.encrypted_password = self.class.encrypt_password(self.password, self.salt)
      self.password = self.password_confirmation = nil
    end

    def validate_password_update
      if self.lost_password_token
        lost_password = lost_passwords.find_by_token(self.lost_password_token)
        if lost_password.nil?
          errors.add :lost_password_token, 'is invalid'
        end
      end
    end
end
