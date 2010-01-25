require 'digest/sha1'

module Concerns
  module Authenticated
    def self.included(model)
      model.class_eval do
        before_save :encrypt_password, :if => :password_given?

        attr_accessor :password
        attr_protected :encrypted_password, :salt

        extend ClassMethods
      end
    end

    module ClassMethods
      def authenticate(email, password)
        if (record = find_by_email(email)) && record.authenticate(password)
          record
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
      def password_given?
        !password.nil?
      end
    
      def encrypt_password
        self.salt = ActiveSupport::SecureRandom.base64(16)
        self.encrypted_password = self.class.encrypt_password(self.password, self.salt)
        self.password = nil
      end
  end
end