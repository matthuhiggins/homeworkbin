require 'digest/sha1'

class Person
  module Authenticated
    def self.included(person)
      person.class_eval do
        has_many :lost_passwords

        before_save :encrypt_password

        attr_accessor :password
        attr_protected :encrypted_password, :salt

        validates_confirmation_of :password, :on => :create
        validates_presence_of     :password, :on => :create
        validates_presence_of     :password, :on => :update, :unless => Proc.new { |person| person.password.nil? }

        extend ClassMethods
      end
    end

    module ClassMethods
      def authenticate(email, password)
        if (person = find_by_email(email)) && person.authenticate(password)
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
      self.encrypted_password == self.class.encrypt_password(pwd, self.salt)
    end

    private
      def encrypt_password
        return if password.nil?
        self.salt = ActiveSupport::SecureRandom.base64(16)
        self.encrypted_password = self.class.encrypt_password(self.password, self.salt)
        self.password = self.password_confirmation = nil
      end
  end
end