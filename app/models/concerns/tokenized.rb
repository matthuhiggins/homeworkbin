module Concerns
  module Tokenized
    def self.included model
      model.before_create do |record|
        record.token = ActiveSupport::SecureRandom.hex(16)
      end
      
      model.extend ClassMethods
    end

    module ClassMethods
      def prune
        scoped(:conditions => ['created_at < ?', 7.days.ago]).delete_all
      end
    end

    def to_param
      token
    end
  end
end
