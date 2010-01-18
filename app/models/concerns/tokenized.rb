module Concerns
  module Tokenized
    def self.included model
      model.before_create do |record|
        record.token = ActiveSupport::SecureRandom.hex(16)
      end
    end
  end
end
