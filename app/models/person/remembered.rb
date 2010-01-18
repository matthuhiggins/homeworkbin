class Person
  module Remembered
    def remember_me!
      update_attribute :remember_token, ActiveSupport::SecureRandom.base64(32)
    end

    def forget_me!
      update_attribute :remember_token, nil
    end
  end
end