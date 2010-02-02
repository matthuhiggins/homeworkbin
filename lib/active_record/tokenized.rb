module ActiveRecord
  module Tokenized
    mattr_accessor :models
    self.models = []
    
    def self.included model
      models << model
      
      model.class_eval do
        before_create do |record|
          record.token = ActiveSupport::SecureRandom.hex(16)
        end
      
        extend ClassMethods
      end
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
