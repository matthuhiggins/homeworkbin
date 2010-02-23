module Disciplines
  module Topic
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def topic(value)
        self.class_eval %{def topic; #{value.inspect}; end}
      end
    end

    def topic; end
  end
end