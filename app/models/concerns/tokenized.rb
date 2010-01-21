module Concerns
  module Tokenized
    def self.included model
      model.before_create do |record|
        record.token = ActiveSupport::SecureRandom.hex(16)
      end
    end
    
    def to_param
      token
    end
  end
end
