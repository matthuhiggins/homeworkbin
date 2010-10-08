module Disciplines
  module Topic
    extend ActiveSupport::Concern

    included do
      class_attribute :sub_menu
      class_attribute :topic
    end

    module ClassMethods
      def shows_sub_menu(sub_menu)
        self.sub_menu = sub_menu
      end

      def shows_topic(topic)
        self.topic = topic
      end
    end

    def show_sub_menu?
      !sub_menu.nil?
    end

    def sub_menu_partial
      "sub_menus/#{sub_menu}"
    end
  end
end