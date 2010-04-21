module ActiveRecord
  module Tokenized
    extend ActiveSupport::Concern
    
    mattr_accessor :models
    self.models = []
    
    included do
     Tokenized.models << self

      before_create do |record|
        record.token = ActiveSupport::SecureRandom.hex(16)
      end
    end

    module ClassMethods
      def prune
        where(['created_at < ?', 7.days.ago]).delete_all
      end
    end

    def to_param
      token
    end
  end
end
