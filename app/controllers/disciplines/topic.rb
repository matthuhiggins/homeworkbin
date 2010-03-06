module Disciplines
  module Topic
    extend ActiveSupport::Concern

    module ClassMethods
      def topic(value)
        self.class_eval %{def topic; #{value.inspect}; end}
      end
    end

    def topic; end
  end
end